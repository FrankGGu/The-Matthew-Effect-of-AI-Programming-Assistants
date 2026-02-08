impl Solution {
    pub fn minimize_the_maximum_difference(mut nums: Vec<i32>, p: i32) -> i32 {
        if p == 0 {
            return 0;
        }

        nums.sort();
        let n = nums.len();

        let can_form_p_pairs = |max_diff: i32| -> bool {
            let mut count = 0;
            let mut i = 0;
            while i < n - 1 {
                if nums[i + 1] - nums[i] <= max_diff {
                    count += 1;
                    i += 2;
                } else {
                    i += 1;
                }
                if count >= p {
                    return true;
                }
            }
            count >= p
        };

        let mut low = 0;
        let mut high = nums[n - 1] - nums[0];
        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            if can_form_p_pairs(mid) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        ans
    }
}