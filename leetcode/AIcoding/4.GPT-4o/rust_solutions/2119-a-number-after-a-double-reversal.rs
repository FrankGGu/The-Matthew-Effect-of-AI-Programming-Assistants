impl Solution {
    pub fn is_number_double_reversal(num: i32) -> bool {
        let reversed = num.to_string().chars().rev().collect::<String>();
        let double_reversed = reversed.trim_start_matches('0').chars().rev().collect::<String>();
        double_reversed.parse::<i32>().unwrap_or(0) == num
    }
}