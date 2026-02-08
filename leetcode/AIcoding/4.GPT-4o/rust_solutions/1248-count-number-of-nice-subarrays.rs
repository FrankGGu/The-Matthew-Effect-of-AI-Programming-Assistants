impl Solution {
    pub fn number_of_nice_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let (mut left, mut right) = (0, 0);
        let mut odd_count = 0;

        while right < nums.len() {
            if nums[right] % 2 == 1 {
                odd_count += 1;
            }

            while odd_count > k {
                if nums[left] % 2 == 1 {
                    odd_count -= 1;
                }
                left += 1;
            }

            if odd_count == k {
                let mut temp_left = left;
                while temp_left < nums.len() && nums[temp_left] % 2 == 0 {
                    temp_left += 1;
                }
                let mut temp_right = right;
                while temp_right < nums.len() && nums[temp_right] % 2 == 0 {
                    temp_right += 1;
                }

                count += (temp_left - left + 1) * (temp_right - right + 1);
            }

            right += 1;
        }

        count
    }
}