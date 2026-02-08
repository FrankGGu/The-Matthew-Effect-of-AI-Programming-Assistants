impl Solution {
    pub fn maximum_beauty(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable();

        let mut max_beauty = 0;
        let mut left = 0;

        for right in 0..nums.len() {
            // The condition for all elements in the subarray nums[left..=right]
            // to be made equal to some value T is that the range of values
            // (nums[right] - nums[left]) must not exceed 2*k.
            // This is because we can choose T to be any value in the intersection
            // of [nums[i] - k, nums[i] + k] for all i in [left, right].
            // The intersection is [nums[right] - k, nums[left] + k].
            // For this intersection to be non-empty, we need nums[right] - k <= nums[left] + k,
            // which simplifies to nums[right] - nums[left] <= 2 * k.
            while nums[right] - nums[left] > 2 * k {
                left += 1;
            }

            // At this point, the subarray nums[left..=right] is a valid candidate.
            // All elements within this window can be made equal to a single value.
            // The length of this subarray is (right - left + 1).
            max_beauty = max_beauty.max((right - left + 1) as i32);
        }

        max_beauty
    }
}