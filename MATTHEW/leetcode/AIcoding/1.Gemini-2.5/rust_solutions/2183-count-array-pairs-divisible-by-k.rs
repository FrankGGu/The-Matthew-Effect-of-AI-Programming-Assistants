use std::collections::HashMap;

impl Solution {
    fn gcd(a: i64, b: i64) -> i64 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn count_pairs(nums: Vec<i32>, k: i32) -> i64 {
        let k_long = k as i64;
        let mut ans = 0i64;
        let mut gcd_counts: HashMap<i64, i64> = HashMap::new();

        for &num_val in nums.iter() {
            let num_long = num_val as i64;

            // Calculate gcd(nums[i], k)
            let g_i = Self::gcd(num_long, k_long);

            // We need to find nums[j] (j < i) such that (nums[i] * nums[j]) % k == 0.
            // This is equivalent to (k / gcd(nums[i], k)) dividing nums[j].
            // Let required_divisor_for_j = k / g_i.
            let required_divisor_for_j = k_long / g_i;

            // Iterate through previously seen gcd_vals and their counts.
            // A number nums[j] with gcd(nums[j], k) = g_prev satisfies the condition
            // if nums[j] is a multiple of required_divisor_for_j.
            // If g_prev itself is a multiple of required_divisor_for_j,
            // then any nums[j] such that gcd(nums[j], k) = g_prev will be a multiple of g_prev,
            // and thus a multiple of required_divisor_for_j.
            for (&g_prev, &count_prev) in gcd_counts.iter() {
                if g_prev % required_divisor_for_j == 0 {
                    ans += count_prev;
                }
            }

            // Add the current num_val's gcd(num_val, k) to the frequency map.
            *gcd_counts.entry(g_i).or_insert(0) += 1;
        }

        ans
    }
}