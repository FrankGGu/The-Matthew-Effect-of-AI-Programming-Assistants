use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn get_number(root: Option<Rc<RefCell<TreeNode>>>, ops: Vec<Vec<i32>>) -> i32 {
        let mut nums = Vec::new();
        Solution::inorder(&root, &mut nums);
        let mut seg = SegmentTree::new(&nums);
        for op in ops {
            let (t, x, y) = (op[0], op[1], op[2]);
            seg.update(x, y, t);
        }
        seg.query_all()
    }

    fn inorder(root: &Option<Rc<RefCell<TreeNode>>>, nums: &mut Vec<i32>) {
        if let Some(node) = root {
            let node = node.borrow();
            Solution::inorder(&node.left, nums);
            nums.push(node.val);
            Solution::inorder(&node.right, nums);
        }
    }
}

struct SegmentTree {
    n: usize,
    color: Vec<i32>,
    set: Vec<i32>,
}

impl SegmentTree {
    fn new(nums: &[i32]) -> Self {
        let n = nums.len();
        Self {
            n,
            color: vec![0; 4 * n],
            set: vec![-1; 4 * n],
        }
    }

    fn push(&mut self, o: usize, l: usize, r: usize) {
        if self.set[o] != -1 {
            self.color[o] = self.set[o] * ((r - l + 1) as i32);
            if l != r {
                self.set[2 * o] = self.set[o];
                self.set[2 * o + 1] = self.set[o];
            }
            self.set[o] = -1;
        }
    }

    fn update(&mut self, ql: i32, qr: i32, color: i32) {
        self.update_range(1, 0, self.n - 1, ql, qr, color);
    }

    fn update_range(&mut self, o: usize, l: usize, r: usize, ql: i32, qr: i32, color: i32) {
        self.push(o, l, r);
        if ql > qr || l > r || ql > r as i32 || qr < l as i32 {
            return;
        }
        if ql <= l as i32 && r as i32 <= qr {
            self.set[o] = color;
            self.push(o, l, r);
            return;
        }
        let m = l + (r - l) / 2;
        self.update_range(2 * o, l, m, ql, qr, color);
        self.update_range(2 * o + 1, m + 1, r, ql, qr, color);
        self.color[o] = self.color[2 * o] + self.color[2 * o + 1];
    }

    fn query_all(&mut self) -> i32 {
        self.query_range(1, 0, self.n - 1, 0, (self.n - 1) as i32)
    }

    fn query_range(&mut self, o: usize, l: usize, r: usize, ql: i32, qr: i32) -> i32 {
        self.push(o, l, r);
        if ql > qr || l > r || ql > r as i32 || qr < l as i32 {
            return 0;
        }
        if ql <= l as i32 && r as i32 <= qr {
            return self.color[o];
        }
        let m = l + (r - l) / 2;
        self.query_range(2 * o, l, m, ql, qr) + self.query_range(2 * o + 1, m + 1, r, ql, qr)
    }
}