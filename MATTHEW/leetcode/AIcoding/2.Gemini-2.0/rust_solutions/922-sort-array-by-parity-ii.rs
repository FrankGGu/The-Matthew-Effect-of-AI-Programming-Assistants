impl Solution {
    pub fn sort_array_by_parity_ii(nums: Vec<i32>) -> Vec<i32> {
        let mut result = vec![0; nums.len()];
        let mut even_index = 0;
        let mut odd_index = 1;

        for &num in &nums {
            if num % 2 == 0 {
                result[even_index] = num;
                even_index += 2;
            } else {
                result[odd_index] = num;
                odd_index += 2;
            }
        }

        result
    }
}