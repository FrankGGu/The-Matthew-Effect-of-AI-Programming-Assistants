struct SegmentTreeNode {
    left: Option<Box<SegmentTreeNode>>,
    right: Option<Box<SegmentTreeNode>>,
    l: usize,
    r: usize,
    sum: i64,
    lazy: i64,
}

impl SegmentTreeNode {
    fn new(l: usize, r: usize, nums: &[i32]) -> Self {
        if l == r {
            return SegmentTreeNode {
                left: None,
                right: None,
                l,
                r,
                sum: nums[l] as i64,
                lazy: 0,
            };
        }
        let mid = l + (r - l) / 2;
        let left = Box::new(SegmentTreeNode::new(l, mid, nums));
        let right = Box::new(SegmentTreeNode::new(mid + 1, r, nums));
        let sum = left.sum + right.sum;
        SegmentTreeNode {
            left: Some(left),
            right: Some(right),
            l,
            r,
            sum,
            lazy: 0,
        }
    }

    fn push_down(&mut self) {
        if self.lazy != 0 {
            if let Some(left) = &mut self.left {
                left.sum = (left.r - left.l + 1) as i64 - left.sum;
                left.lazy ^= 1;
            }
            if let Some(right) = &mut self.right {
                right.sum = (right.r - right.l + 1) as i64 - right.sum;
                right.lazy ^= 1;
            }
            self.lazy = 0;
        }
    }

    fn update_range(&mut self, l: usize, r: usize) {
        if self.r < l || self.l > r {
            return;
        }
        if l <= self.l && self.r <= r {
            self.sum = (self.r - self.l + 1) as i64 - self.sum;
            self.lazy ^= 1;
            return;
        }
        self.push_down();
        if let Some(left) = &mut self.left {
            left.update_range(l, r);
        }
        if let Some(right) = &mut self.right {
            right.update_range(l, r);
        }
        self.sum = self.left.as_ref().unwrap().sum + self.right.as_ref().unwrap().sum;
    }

    fn query_sum(&self) -> i64 {
        self.sum
    }
}

struct Solution;

impl Solution {
    pub fn handle_query(nums1: Vec<i32>, nums2: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i64> {
        let n = nums1.len();
        let mut root = SegmentTreeNode::new(0, n - 1, &nums1);
        let mut sum2 = nums2.iter().map(|&x| x as i64).sum::<i64>();
        let mut res = Vec::new();
        for query in queries {
            match query[0] {
                1 => {
                    let l = query[1] as usize;
                    let r = query[2] as usize;
                    root.update_range(l, r);
                }
                2 => {
                    let p = query[1] as i64;
                    sum2 += p * root.query_sum();
                }
                3 => {
                    res.push(sum2);
                }
                _ => {}
            }
        }
        res
    }
}