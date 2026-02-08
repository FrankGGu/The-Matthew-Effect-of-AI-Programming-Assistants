use std::collections::HashMap;

impl Solution {
    pub fn count_subarrays_with_median_k(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut arr = vec![0; n];
        let mut k_idx = 0;

        for i in 0..n {
            if nums[i] > k {
                arr[i] = 1;
            } else if nums[i] < k {
                arr[i] = -1;
            } else {
                arr[i] = 0;
                k_idx = i;
            }
        }

        let mut left_counts: HashMap<i32, i32> = HashMap::new();
        let mut current_sum = 0;

        // Calculate prefix sums for subarrays ending at k_idx (moving left from k_idx)
        // These sums are sum(arr[i..k_idx]) for i <= k_idx.
        // Since arr[k_idx] is 0, this is effectively sum(arr[i..k_idx-1]) for i < k_idx,
        // and 0 for i = k_idx.
        for i in (0..=k_idx).rev() {
            current_sum += arr[i];
            *left_counts.entry(current_sum).or_insert(0) += 1;
        }

        let mut ans = 0;
        current_sum = 0; // This current_sum will represent sum(arr[k_idx..j])

        // Iterate from k_idx to the right
        for j in k_idx..n {
            current_sum += arr[j];

            // We are looking for subarrays [i..j] such that i <= k_idx <= j.
            // The sum of such a subarray is sum(arr[i..j]).
            // This can be split as: sum(arr[i..k_idx]) + sum(arr[k_idx+1..j]).
            // Let S_L = sum(arr[i..k_idx]). These are the keys in `left_counts`.
            // Let S_R_prime = sum(arr[k_idx+1..j]).
            // The `current_sum` in this loop is sum(arr[k_idx..j]).
            // Since arr[k_idx] is 0, sum(arr[k_idx..j]) = arr[k_idx] + sum(arr[k_idx+1..j])
            //   = 0 + S_R_prime = S_R_prime.
            // So, `current_sum` effectively represents S_R_prime.
            // We need S_L + S_R_prime = 0 or S_L + S_R_prime = 1.
            // Substituting S_R_prime with `current_sum`:
            // We need S_L + current_sum = 0  =>  S_L = -current_sum
            // OR   S_L + current_sum = 1  =>  S_L = 1 - current_sum

            let target1 = -current_sum;
            let target2 = 1 - current_sum;

            ans += left_counts.get(&target1).unwrap_or(&0);
            ans += left_counts.get(&target2).unwrap_or(&0);
        }

        ans
    }
}