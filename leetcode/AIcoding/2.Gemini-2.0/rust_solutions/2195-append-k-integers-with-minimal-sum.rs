use std::collections::HashSet;

impl Solution {
    pub fn append_k_integers(nums: Vec<i32>, k: i32) -> i64 {
        let mut seen: HashSet<i32> = HashSet::new();
        for &num in &nums {
            seen.insert(num);
        }

        let mut count = 0;
        let mut sum: i64 = 0;
        let mut num = 1;

        while count < k {
            if !seen.contains(&num) {
                sum += num as i64;
                count += 1;
            }
            num += 1;
        }

        sum
    }
}