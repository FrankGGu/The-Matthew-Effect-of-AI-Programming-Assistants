impl Solution {
    pub fn find_duplicates(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        let mut result = Vec::new();
        for i in 0..nums.len() {
            let index = (nums[i].abs() - 1) as usize;
            if nums[index] < 0 {
                result.push((index + 1) as i32);
            } else {
                nums[index] *= -1;
            }
        }
        result
    }
}