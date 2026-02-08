struct SegmentTree {
    tree: Vec<i32>,
    n: usize,
}

impl SegmentTree {
    fn new(size: usize) -> Self {
        let mut n = 1;
        while n < size {
            n <<= 1;
        }
        SegmentTree {
            tree: vec![0; 2 * n],
            n,
        }
    }

    fn update(&mut self, mut pos: usize, val: i32) {
        pos += self.n;
        self.tree[pos] = val;
        pos >>= 1;
        while pos >= 1 {
            self.tree[pos] = self.tree[2 * pos].max(self.tree[2 * pos + 1]);
            pos >>= 1;
        }
    }

    fn query(&self, mut l: usize, mut r: usize) -> i32 {
        l += self.n;
        r += self.n;
        let mut res = 0;
        while l <= r {
            if l % 2 == 1 {
                res = res.max(self.tree[l]);
                l += 1;
            }
            if r % 2 == 0 {
                res = res.max(self.tree[r]);
                r -= 1;
            }
            l >>= 1;
            r >>= 1;
        }
        res
    }
}

impl Solution {
    pub fn length_of_lis(nums: Vec<i32>, k: i32) -> i32 {
        let max_num = *nums.iter().max().unwrap() as usize;
        let mut st = SegmentTree::new(max_num + 1);
        let mut res = 0;
        for num in nums {
            let num = num as usize;
            let l = if num > k as usize { num - k as usize } else { 0 };
            let r = num - 1;
            let curr = st.query(l, r) + 1;
            res = res.max(curr);
            st.update(num, curr);
        }
        res
    }
}