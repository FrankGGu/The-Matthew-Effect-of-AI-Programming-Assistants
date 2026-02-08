impl Solution {
    pub fn max_difference_even_odd_frequency(nums: Vec<i32>) -> i32 {
        let mut even_count = 0;
        let mut odd_count = 0;

        for num in nums {
            if num % 2 == 0 {
                even_count += 1;
            } else {
                odd_count += 1;
            }
        }

        (even_count - odd_count).abs()
    }
}