use std::collections::HashSet;

impl Solution {
    pub fn closest_to_target(arr: Vec<i32>, target: i32) -> i32 {
        let mut res = std::i32::MAX;
        let mut prev = HashSet::new();
        for &num in arr.iter() {
            let mut curr = HashSet::new();
            curr.insert(num);
            for &val in prev.iter() {
                curr.insert(val | num);
            }
            for &val in curr.iter() {
                if (val - target).abs() < res.abs() {
                    res = val - target;
                } else if (val - target).abs() == res.abs() && val - target > res {
                    res = val - target;
                }
            }
            prev = curr;
        }
        res.abs()
    }
}