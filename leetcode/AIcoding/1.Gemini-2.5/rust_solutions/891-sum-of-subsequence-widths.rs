impl Solution {
    pub fn sum_subseq_widths(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let n = nums.len();
        let modulo = 1_000_000_007;

        let mut powers_of_2 = vec![0; n];
        powers_of_2[0] = 1;
        for i in 1..n {
            powers_of_2[i] = (powers_of_2[i - 1] * 2) % modulo;
        }

        let mut total_sum: i64 = 0;

        for i in 0..n {
            let num = nums[i] as i64;

            // Coefficient for nums[i] when it is the maximum element in a subsequence
            // There are 2^i subsequences where nums[i] is the maximum (choosing elements from nums[0...i-1])
            let max_coeff = powers_of_2[i]; 

            // Coefficient for nums[i] when it is the minimum element in a subsequence
            // There are 2^(n-1-i) subsequences where nums[i] is the minimum (choosing elements from nums[i+1...n-1])
            let min_coeff = powers_of_2[n - 1 - i]; 

            // The net contribution of nums[i] to the total sum is num * (2^i - 2^(n-1-i))
            let term = (max_coeff - min_coeff + modulo) % modulo;
            let contribution = (num * term) % modulo;

            total_sum = (total_sum + contribution) % modulo;
        }

        total_sum as i32
    }
}