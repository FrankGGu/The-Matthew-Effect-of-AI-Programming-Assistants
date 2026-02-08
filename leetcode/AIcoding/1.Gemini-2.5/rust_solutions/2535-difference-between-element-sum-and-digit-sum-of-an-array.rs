impl Solution {
    pub fn difference_of_sum(nums: Vec<i32>) -> i32 {
        let mut element_sum = 0;
        let mut digit_sum = 0;

        for num in nums {
            element_sum += num;
            let mut temp_num = num;
            while temp_num > 0 {
                digit_sum += temp_num % 10;
                temp_num /= 10;
            }
        }

        (element_sum - digit_sum).abs()
    }
}