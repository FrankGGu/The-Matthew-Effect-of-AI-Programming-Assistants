use std::collections::HashSet;

impl Solution {
    pub fn smallest_missing_value_subtree(parents: Vec<i32>, nums: Vec<i32>) -> Vec<i32> {
        let n = parents.len();
        let mut children = vec![vec![]; n];
        for i in 1..n {
            let p = parents[i] as usize;
            children[p].push(i);
        }

        let mut res = vec![1; n];
        let mut seen = HashSet::new();
        let mut missing = 1;

        let mut node = match nums.iter().position(|&x| x == 1) {
            Some(idx) => idx,
            None => return res,
        };

        while node != std::usize::MAX {
            let mut stack = vec![node];
            while let Some(u) = stack.pop() {
                if seen.insert(nums[u]) {
                    for &v in &children[u] {
                        stack.push(v);
                    }
                }
            }
            while seen.contains(&missing) {
                missing += 1;
            }
            res[node] = missing;
            node = parents[node] as usize;
        }

        res
    }
}