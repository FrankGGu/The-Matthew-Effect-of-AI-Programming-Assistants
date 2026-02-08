use std::collections::BTreeSet;

struct FenwickTree {
    size: usize,
    tree: Vec<i32>,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        FenwickTree {
            size,
            tree: vec![0; size + 1],
        }
    }

    fn update(&mut self, mut index: usize, delta: i32) {
        while index <= self.size {
            self.tree[index] += delta;
            index += index & (!index + 1);
        }
    }

    fn query(&self, mut index: usize) -> i32 {
        let mut res = 0;
        while index > 0 {
            res += self.tree[index];
            index -= index & (!index + 1);
        }
        res
    }
}

impl Solution {
    pub fn good_triplets(nums1: Vec<i32>, nums2: Vec<i32>) -> i64 {
        let n = nums1.len();
        let mut pos = vec![0; n];
        for (i, &num) in nums2.iter().enumerate() {
            pos[num as usize] = i;
        }

        let mut bit_left = FenwickTree::new(n);
        let mut left = vec![0; n];
        for i in 0..n {
            let p = pos[nums1[i] as usize] + 1;
            left[i] = bit_left.query(p - 1);
            bit_left.update(p, 1);
        }

        let mut bit_right = FenwickTree::new(n);
        let mut right = vec![0; n];
        for i in (0..n).rev() {
            let p = pos[nums1[i] as usize] + 1;
            right[i] = bit_right.query(n) - bit_right.query(p);
            bit_right.update(p, 1);
        }

        let mut res = 0;
        for i in 0..n {
            res += left[i] as i64 * right[i] as i64;
        }
        res
    }
}