impl Solution {
    pub fn find_disappeared_numbers(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        let n = nums.len();

        for i in 0..n {
            let index = (nums[i].abs() as usize) - 1;
            if nums[index] > 0 {
                nums[index] = -nums[index];
            }
        }

        let mut result = Vec::new();
        for i in 0..n {
            if nums[i] > 0 {
                result.push((i + 1) as i32);
            }
        }

        result
    }
}