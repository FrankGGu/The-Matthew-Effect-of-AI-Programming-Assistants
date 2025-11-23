impl Solution {
    pub fn min_capability(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();

        if k == 0 {
            return 0;
        }

        let mut low = 1;
        let mut high = 1_000_000_000;

        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;

            if Self::can_rob_k_houses(&nums, k, mid) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn can_rob_k_houses(nums: &[i32], k: i32, max_val: i32) -> bool {
        let mut robbed_count = 0;
        let mut i = 0;
        while i < nums.len() {
            if nums[i] <= max_val {
                robbed_count += 1;
                i += 2;
            } else {
                i += 1;
            }
        }
        robbed_count >= k
    }
}