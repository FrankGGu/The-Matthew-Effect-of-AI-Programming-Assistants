impl Solution {
    pub fn wiggle_sort(nums: &mut Vec<i32>) {
        let n = nums.len();
        let mut sorted_nums = nums.clone();
        sorted_nums.sort();

        let mut k = n - 1;
        for i in (1..n).step_by(2) {
            nums[i] = sorted_nums[k];
            k -= 1;
        }
        for i in (0..n).step_by(2) {
            nums[i] = sorted_nums[k];
            k -= 1;
        }
    }
}