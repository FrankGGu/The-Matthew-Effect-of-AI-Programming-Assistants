impl Solution {
    pub fn count_pairs(mut nums: Vec<i32>, target: i32) -> i32 {
        nums.sort();
        let n = nums.len();
        let mut count = 0;
        let mut left = 0;
        let mut right = n - 1;

        while left < right {
            if nums[left] + nums[right] < target {
                // If nums[left] + nums[right] is less than target,
                // then all pairs (nums[left], nums[k]) where left < k <= right
                // will also have a sum less than target, because nums[k] <= nums[right].
                // The number of such elements k is (right - left).
                count += (right - left) as i32;
                left += 1; // Move left pointer to consider the next element
            } else {
                // If nums[left] + nums[right] is greater than or equal to target,
                // nums[right] is too large. We need a smaller sum, so decrement right pointer.
                right -= 1;
            }
        }
        count
    }
}