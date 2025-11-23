impl Solution {
    pub fn find_sum_of_encrypted_integers(nums: Vec<i32>) -> i32 {
        let mut sum = 0;
        for &num in &nums {
            sum += num;
        }
        sum
    }
}