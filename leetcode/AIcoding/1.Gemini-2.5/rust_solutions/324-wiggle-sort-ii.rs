impl Solution {
    pub fn wiggle_sort(nums: &mut Vec<i32>) {
        let n = nums.len();
        if n <= 1 {
            return;
        }

        let mut sorted_nums = nums.clone();
        sorted_nums.sort_unstable();

        let mut left_ptr = (n - 1) / 2;
        let mut right_ptr = n - 1;

        for i in 0..n {
            if i % 2 == 0 {
                nums[i] = sorted_nums[left_ptr];
                left_ptr -= 1;
            } else {
                nums[i] = sorted_nums[right_ptr];
                right_ptr -= 1;
            }
        }
    }
}