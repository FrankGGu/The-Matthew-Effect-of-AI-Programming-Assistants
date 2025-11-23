impl Solution {
    pub fn subarrays_div_by_k(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut prefix_sum = 0;
        let mut remainder_counts = vec![0; k as usize];

        remainder_counts[0] = 1;

        for num in nums {
            prefix_sum += num;
            let current_remainder = (prefix_sum % k + k) % k;

            count += remainder_counts[current_remainder as usize];

            remainder_counts[current_remainder as usize] += 1;
        }

        count
    }
}