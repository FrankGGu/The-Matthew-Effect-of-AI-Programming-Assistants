impl Solution {
    pub fn count_beautiful_splits(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;

        let first_val = nums[0];
        let last_val = nums[n - 1];
        let mut count = 0;

        // A split is defined by an index `i` such that:
        // left subarray: nums[0...i]
        // right subarray: nums[i+1...n-1]

        // Conditions for a beautiful split:
        // 1. left and right have the same first element: nums[0] == nums[i+1]
        // 2. left and right have the same last element: nums[i] == nums[n-1]
        // 3. length of left >= k: (i + 1) >= k  =>  i >= k - 1
        // 4. length of right >= k: (n - 1 - (i + 1) + 1) >= k  =>  (n - 1 - i) >= k  =>  i <= n - 1 - k

        // Combining conditions 3 and 4, the valid range for `i` is:
        // k - 1 <= i <= n - 1 - k
        // The problem constraint `1 <= k <= nums.length / 2` ensures that `k - 1 <= n - 1 - k`,
        // so the loop range is always valid and contains at least one element.
        for i in k - 1..=(n - 1 - k) {
            if nums[i + 1] == first_val && nums[i] == last_val {
                count += 1;
            }
        }

        count
    }
}