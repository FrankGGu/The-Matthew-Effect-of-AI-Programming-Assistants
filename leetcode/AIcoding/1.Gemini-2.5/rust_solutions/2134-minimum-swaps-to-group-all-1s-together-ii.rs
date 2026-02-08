impl Solution {
    pub fn min_swaps(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let total_ones = nums.iter().filter(|&&x| x == 1).count();

        if total_ones == 0 || total_ones == 1 {
            return 0;
        }

        let mut doubled_nums = Vec::with_capacity(2 * n);
        doubled_nums.extend_from_slice(&nums);
        doubled_nums.extend_from_slice(&nums);

        let mut current_ones_in_window = 0;
        for i in 0..total_ones {
            if doubled_nums[i] == 1 {
                current_ones_in_window += 1;
            }
        }

        let mut max_ones_in_window = current_ones_in_window;

        for i in total_ones..(n + total_ones) {
            if doubled_nums[i - total_ones] == 1 {
                current_ones_in_window -= 1;
            }
            if doubled_nums[i] == 1 {
                current_ones_in_window += 1;
            }
            max_ones_in_window = max_ones_in_window.max(current_ones_in_window);
        }

        (total_ones - max_ones_in_window) as i32
    }
}