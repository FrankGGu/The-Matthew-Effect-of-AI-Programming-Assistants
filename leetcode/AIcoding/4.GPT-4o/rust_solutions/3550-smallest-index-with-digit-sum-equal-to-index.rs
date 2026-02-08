impl Solution {
    pub fn smallest_index_with_digit_sum_equal_to_index(num: i32) -> i32 {
        let num_str = num.to_string();
        for i in 0..num_str.len() {
            let digit_sum: i32 = num_str.chars().take(i + 1).map(|c| c.to_digit(10).unwrap() as i32).sum();
            if digit_sum == i as i32 {
                return i as i32;
            }
        }
        -1
    }
}