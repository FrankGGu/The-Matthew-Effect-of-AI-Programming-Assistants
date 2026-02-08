use std::collections::BTreeMap;

impl Solution {
    pub fn make_array_empty(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut map = BTreeMap::new();
        for i in 0..n {
            map.entry(nums[i]).or_insert(vec![]).push(i);
        }

        let mut fenwick = FenwickTree::new(n);
        let mut ans = 0;
        let mut removed = 0;

        for (&_, indices) in map.iter() {
            for &index in indices {
                let pos = (index + removed) % n;
                ans += pos as i64 + 1 - fenwick.query(pos);
                fenwick.update(pos, 1);
                removed += 1;
            }
        }

        ans
    }
}

struct FenwickTree {
    tree: Vec<i64>,
    n: usize,
}

impl FenwickTree {
    fn new(n: usize) -> Self {
        FenwickTree {
            tree: vec![0; n + 1],
            n,
        }
    }

    fn update(&mut self, i: usize, val: i64) {
        let mut i = i + 1;
        while i <= self.n {
            self.tree[i] += val;
            i += i & (!i + 1);
        }
    }

    fn query(&self, i: usize) -> i64 {
        let mut i = i + 1;
        let mut sum = 0;
        while i > 0 {
            sum += self.tree[i];
            i &= i - 1;
        }
        sum
    }
}

struct Solution;