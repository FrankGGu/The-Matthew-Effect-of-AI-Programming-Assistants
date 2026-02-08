use std::collections::HashMap;

impl Solution {
    pub fn count_array_pairs_divisible_by_k(nums: Vec<i32>, k: i32) -> i64 {
        let mut count: i64 = 0;
        let mut gcd_counts: HashMap<i32, i32> = HashMap::new();

        for &num in &nums {
            let gcd_num_k = Solution::gcd(num, k);
            let required_gcd = k / Solution::gcd(num, k);

            if gcd_counts.contains_key(&required_gcd) {
                count += *gcd_counts.get(&required_gcd).unwrap() as i64;
            }

            *gcd_counts.entry(gcd_num_k).or_insert(0) += 1;
        }

        count
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Solution::gcd(b, a % b)
        }
    }
}