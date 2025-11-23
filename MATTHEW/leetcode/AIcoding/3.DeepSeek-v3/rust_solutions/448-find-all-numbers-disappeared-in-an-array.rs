impl Solution {
    pub fn find_disappeared_numbers(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        let n = nums.len();
        for i in 0..n {
            let idx = (nums[i].abs() as usize) - 1;
            if nums[idx] > 0 {
                nums[idx] *= -1;
            }
        }
        let mut res = Vec::new();
        for i in 0..n {
            if nums[i] > 0 {
                res.push((i + 1) as i32);
            }
        }
        res
    }
}