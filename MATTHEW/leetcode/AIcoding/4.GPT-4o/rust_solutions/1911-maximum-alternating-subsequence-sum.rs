impl Solution {
    pub fn max_alternating_sum(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut even_sum = 0;
        let mut odd_sum = 0;

        for &num in &nums {
            even_sum = even_sum.max(odd_sum + num as i64);
            odd_sum += num as i64;
        }

        even_sum
    }
}