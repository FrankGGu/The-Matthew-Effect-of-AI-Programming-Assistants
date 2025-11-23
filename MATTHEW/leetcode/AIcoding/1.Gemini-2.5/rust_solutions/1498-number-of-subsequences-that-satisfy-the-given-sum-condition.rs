impl Solution {
    pub fn num_subseq(mut nums: Vec<i32>, target: i32) -> i32 {
        nums.sort();
        let n = nums.len();
        let modulo = 1_000_000_007;

        let mut powers_of_2 = vec![1; n];
        for i in 1..n {
            powers_of_2[i] = (powers_of_2[i - 1] * 2) % modulo;
        }

        let mut count = 0;
        let mut left = 0;
        let mut right = n - 1;

        while left <= right {
            if nums[left] + nums[right] <= target {
                // If nums[left] is chosen as the minimum element of a subsequence,
                // and nums[right] is chosen such that nums[left] + nums[right] <= target,
                // then any subsequence formed by nums[left] and any subset of elements
                // from nums[left+1] to nums[right] (inclusive) will satisfy the condition.
                // The minimum element will be nums[left].
                // The maximum element will be some nums[k] where left <= k <= right.
                // Since nums[left] + nums[right] <= target, then nums[left] + nums[k] <= target
                // for any k in the range [left, right].
                // The number of elements between nums[left+1] and nums[right] is (right - 1) - (left + 1) + 1 = right - left - 1.
                // Including nums[left] itself, there are (right - left) elements that can be chosen
                // to form a subsequence where nums[left] is the minimum.
                // The number of ways to choose elements from nums[left+1] to nums[right] is 2^(right - left).
                count = (count + powers_of_2[right - left]) % modulo;
                left += 1;
            } else {
                // The sum nums[left] + nums[right] is too large.
                // To potentially satisfy the condition, we must decrease the maximum element.
                right -= 1;
            }
        }

        count as i32
    }
}