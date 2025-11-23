impl Solution {
    pub fn find_duplicates(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut nums = nums;

        for i in 0..nums.len() {
            let index = (nums[i].abs() - 1) as usize;
            if nums[index] < 0 {
                result.push(index as i32 + 1);
            }
            nums[index] = -nums[index];
        }

        result
    }
}