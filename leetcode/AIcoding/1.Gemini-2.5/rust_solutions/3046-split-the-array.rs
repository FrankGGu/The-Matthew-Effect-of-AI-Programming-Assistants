impl Solution {
    pub fn is_possible_to_split(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let target_count = n / 2;
        let mut odd_count = 0;

        for &num in &nums {
            if num % 2 != 0 {
                odd_count += 1;
            }
        }

        odd_count == target_count
    }
}