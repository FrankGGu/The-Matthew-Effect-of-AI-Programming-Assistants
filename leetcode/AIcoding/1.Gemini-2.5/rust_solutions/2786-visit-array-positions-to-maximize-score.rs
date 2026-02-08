impl Solution {
    pub fn max_score(nums: Vec<i32>, x: i32) -> i64 {
        let n = nums.len();
        let x = x as i64;

        // max_score_even stores the maximum score ending with an even number.
        // max_score_odd stores the maximum score ending with an odd number.
        // Initialize with i64::MIN to represent unreachable states or very small scores.
        let mut max_score_even: i64 = i64::MIN;
        let mut max_score_odd: i64 = i64::MIN;

        // Initialize scores based on the first element
        if nums[0] % 2 == 0 {
            max_score_even = nums[0] as i64;
        } else {
            max_score_odd = nums[0] as i64;
        }

        // Iterate through the rest of the array starting from the second element
        for i in 1..n {
            let current_num = nums[i] as i64;
            let current_parity = current_num % 2;

            // Store previous scores before updating to ensure correct calculation for current step
            let prev_max_score_even = max_score_even;
            let prev_max_score_odd = max_score_odd;

            if current_parity == 0 { // Current number is even
                // Option 1: Extend an even-ending path (same parity, no cost)
                // Option 2: Extend an odd-ending path (different parity, pay x)
                let score_from_even = prev_max_score_even + current_num;
                let score_from_odd = prev_max_score_odd + current_num - x;
                max_score_even = score_from_even.max(score_from_odd);
            } else { // Current number is odd
                // Option 1: Extend an odd-ending path (same parity, no cost)
                // Option 2: Extend an even-ending path (different parity, pay x)
                let score_from_odd = prev_max_score_odd + current_num;
                let score_from_even = prev_max_score_even + current_num - x;
                max_score_odd = score_from_odd.max(score_from_even);
            }
        }

        // The maximum score will be the maximum of the two possible ending states
        max_score_even.max(max_score_odd)
    }
}