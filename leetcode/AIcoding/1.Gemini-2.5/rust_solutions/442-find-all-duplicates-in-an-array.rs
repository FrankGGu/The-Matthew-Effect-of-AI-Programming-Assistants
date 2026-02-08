impl Solution {
    pub fn find_duplicates(mut nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        for i in 0..nums.len() {
            let index = (nums[i].abs() - 1) as usize;
            if nums[index] < 0 {
                result.push(nums[i].abs());
            } else {
                nums[index] = -nums[index];
            }
        }
        result
    }
}