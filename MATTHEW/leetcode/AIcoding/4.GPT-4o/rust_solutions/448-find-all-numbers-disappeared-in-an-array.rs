impl Solution {
    pub fn find_disappeared_numbers(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len() as i32;
        let mut nums = nums;

        for i in 0..nums.len() {
            let index = (nums[i].abs() - 1) as usize;
            if nums[index] > 0 {
                nums[index] = -nums[index];
            }
        }

        let mut result = Vec::new();
        for i in 0..n {
            if nums[i as usize] > 0 {
                result.push(i + 1);
            }
        }

        result
    }
}