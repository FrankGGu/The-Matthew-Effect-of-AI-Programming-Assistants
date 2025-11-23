impl Solution {
    pub fn find_duplicates(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        let mut res = Vec::new();
        for i in 0..nums.len() {
            let idx = (nums[i].abs() - 1) as usize;
            if nums[idx] < 0 {
                res.push(idx as i32 + 1);
            } else {
                nums[idx] *= -1;
            }
        }
        res
    }
}