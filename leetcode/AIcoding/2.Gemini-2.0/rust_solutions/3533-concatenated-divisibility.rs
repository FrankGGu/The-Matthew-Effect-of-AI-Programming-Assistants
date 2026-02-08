impl Solution {
    pub fn solve() -> bool {
        let nums = vec![3,5,7];
        let k = 23;
        Solution::are_concatenated_divisible(nums, k)
    }
    pub fn are_concatenated_divisible(nums: Vec<i32>, k: i32) -> bool {
        let n = nums.len();
        for i in 0..n {
            for j in 0..n {
                if i != j {
                    let num1_str = nums[i].to_string();
                    let num2_str = nums[j].to_string();
                    let concatenated_str = num1_str + &num2_str;
                    let concatenated_num = concatenated_str.parse::<i64>().unwrap();
                    if concatenated_num % k as i64 != 0 {
                        return false;
                    }
                }
            }
        }
        true
    }
}