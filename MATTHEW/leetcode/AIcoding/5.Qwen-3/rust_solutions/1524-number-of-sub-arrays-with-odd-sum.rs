struct Solution;

impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>) -> i32 {
        let mut even = 0;
        let mut odd = 0;
        let mut result = 0;
        let mut sum = 0;

        for num in arr {
            sum += num;
            if sum % 2 == 0 {
                even += 1;
            } else {
                odd += 1;
            }
        }

        result = odd;
        result += (even * (even - 1)) / 2;
        result += (odd * (odd - 1)) / 2;

        result
    }
}