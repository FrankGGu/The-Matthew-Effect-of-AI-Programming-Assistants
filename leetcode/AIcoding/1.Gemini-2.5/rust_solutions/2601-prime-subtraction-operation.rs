impl Solution {
    pub fn prime_sub_operation(nums: Vec<i32>) -> bool {
        let mut prev_modified_val = 0;

        for &num in nums.iter() {
            if num > prev_modified_val {
                prev_modified_val = num;
            } else {
                // We need to subtract a positive prime 'p' such that nums[i] - p > prev_modified_val.
                // To maximize nums[i] - p (giving more room for subsequent elements),
                // we must choose the smallest possible prime 'p'.
                // The smallest prime number is 2.
                // We need p < num - prev_modified_val.
                // Let 'diff' be num - prev_modified_val. We need p < diff.
                // If diff <= 2, there is no prime 'p' (which must be >= 2) such that p < diff.
                // For example:
                // If diff = 2, we need p < 2. No prime satisfies this.
                // If diff = 1, we need p < 1. No prime satisfies this.
                // If diff <= 0, we need p < (non-positive). No prime satisfies this.
                if num - prev_modified_val <= 2 {
                    return false;
                }

                // If num - prev_modified_val > 2, then 'diff' is at least 3.
                // In this case, the smallest prime 'p' that satisfies p < diff is 2.
                // We can subtract 2 from 'num'.
                // The new value will be num - 2.
                // This is valid because if num - prev_modified_val > 2, then num must be at least 3
                // (since prev_modified_val >= 0, e.g., if prev_modified_val=0, num must be > 2).
                // Thus, 2 <= num is guaranteed, so subtracting 2 is always possible.
                prev_modified_val = num - 2;
            }
        }

        true
    }
}