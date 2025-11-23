use std::collections::HashMap;

impl Solution {
    pub fn min_deletions(nums: Vec<i32>, nums_divide: Vec<i32>) -> i32 {
        fn gcd(a: i32, b: i32) -> i32 {
            if b == 0 { a } else { gcd(b, a % b) }
        }

        let mut overall_gcd = nums_divide[0];
        for &num in nums_divide.iter().skip(1) {
            overall_gcd = gcd(overall_gcd, num);
        }

        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut sorted_nums: Vec<i32> = freq.keys().cloned().collect();
        sorted_nums.sort();

        let mut deletions = 0;
        for num in sorted_nums {
            if overall_gcd % num == 0 {
                return deletions;
            }
            deletions += freq[&num];
        }

        -1
    }
}