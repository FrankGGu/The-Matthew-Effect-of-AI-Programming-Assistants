impl Solution {
    pub fn prefixes_div_by5(nums: Vec<i32>) -> Vec<bool> {
        let mut res = Vec::with_capacity(nums.len());
        let mut num = 0;
        for &bit in nums.iter() {
            num = (num * 2 + bit) % 5;
            res.push(num == 0);
        }
        res
    }
}