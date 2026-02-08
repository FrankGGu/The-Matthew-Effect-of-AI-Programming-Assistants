impl Solution {
    pub fn minimize_max(nums: Vec<i32>, p: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut low = 0;
        let mut high = nums[n - 1] - nums[0];

        while low < high {
            let mid = low + (high - low) / 2;
            let mut count = 0;
            let mut i = 0;
            while i < n - 1 {
                if nums[i + 1] - nums[i] <= mid {
                    count += 1;
                    i += 2;
                } else {
                    i += 1;
                }
            }

            if count >= p {
                high = mid;
            } else {
                low = mid + 1;
            }
        }

        low
    }
}