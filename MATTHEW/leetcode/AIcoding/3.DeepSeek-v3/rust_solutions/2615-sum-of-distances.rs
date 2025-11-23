impl Solution {
    pub fn distance(nums: Vec<i32>) -> Vec<i64> {
        use std::collections::HashMap;

        let n = nums.len();
        let mut prefix = HashMap::new();
        let mut suffix = HashMap::new();
        let mut res = vec![0; n];

        for i in 0..n {
            let num = nums[i];
            let entry = prefix.entry(num).or_insert((0, 0));
            res[i] += entry.0 * i as i64 - entry.1;
            entry.0 += 1;
            entry.1 += i as i64;
        }

        for i in (0..n).rev() {
            let num = nums[i];
            let entry = suffix.entry(num).or_insert((0, 0));
            res[i] += entry.1 - entry.0 * i as i64;
            entry.0 += 1;
            entry.1 += i as i64;
        }

        res
    }
}