impl Solution {
    pub fn split_array(nums: Vec<i32>, k: i32) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut low = *nums.iter().max().unwrap_or(&0);
        let mut high = nums.iter().sum::<i32>();

        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, &nums, k) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn check(max_sum_per_subarray: i32, nums: &[i32], k: i32) -> bool {
        let mut subarrays_needed = 1;
        let mut current_subarray_sum = 0;

        for &num in nums.iter() {
            if current_subarray_sum + num <= max_sum_per_subarray {
                current_subarray_sum += num;
            } else {
                subarrays_needed += 1;
                current_subarray_sum = num;
            }
        }
        subarrays_needed <= k
    }
}