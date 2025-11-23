impl Solution {
    pub fn count_elements(nums: Vec<i32>) -> i32 {
        if nums.len() < 3 {
            return 0;
        }
        let min_val = *nums.iter().min().unwrap();
        let max_val = *nums.iter().max().unwrap();
        nums.iter().filter(|&&x| x > min_val && x < max_val).count() as i32
    }
}