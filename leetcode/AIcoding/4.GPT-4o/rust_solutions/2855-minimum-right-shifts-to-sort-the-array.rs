impl Solution {
    pub fn minimum_right_shifts(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut sorted_nums = nums.clone();
        sorted_nums.sort();

        for shift in 0..n {
            let mut valid = true;
            for i in 0..n {
                if nums[(i + shift) % n] != sorted_nums[i] {
                    valid = false;
                    break;
                }
            }
            if valid {
                return shift as i32;
            }
        }
        -1
    }
}