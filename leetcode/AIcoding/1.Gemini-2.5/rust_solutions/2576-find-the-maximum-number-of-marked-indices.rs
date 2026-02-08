impl Solution {
    pub fn max_num_of_marked_indices(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        let mut count = 0;
        let mut left = 0;
        let mut right = n / 2;

        while left < n / 2 && right < n {
            if (nums[left] as i64) * 2 <= (nums[right] as i64) {
                count += 1;
                left += 1;
                right += 1;
            } else {
                right += 1;
            }
        }

        (count * 2) as i32
    }
}