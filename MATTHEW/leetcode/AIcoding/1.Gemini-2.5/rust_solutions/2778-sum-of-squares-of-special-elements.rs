impl Solution {
    pub fn sum_of_squares(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total_sum = 0;
        for (i, &num) in nums.iter().enumerate() {
            if n % (i + 1) == 0 {
                total_sum += num * num;
            }
        }
        total_sum
    }
}