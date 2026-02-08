struct Solution;

impl Solution {
    pub fn kth_palindrome(queries: Vec<i32>, int_length: i32) -> Vec<i64> {
        let mut results = Vec::with_capacity(queries.len());

        let half_len = (int_length + 1) / 2;
        let start_num_val = 10_i64.pow((half_len - 1) as u32);
        let end_num_val = 10_i64.pow(half_len as u32) - 1;

        for &q in queries.iter() {
            let first_half_num = start_num_val + (q as i64) - 1;

            if first_half_num > end_num_val {
                results.push(-1);
                continue;
            }

            let first_half_str = first_half_num.to_string();
            let mut palindrome_str = String::new();
            palindrome_str.push_str(&first_half_str);

            if int_length % 2 == 0 {
                // Even length: reverse the entire first_half_str
                let second_half = first_half_str.chars().rev().collect::<String>();
                palindrome_str.push_str(&second_half);
            } else {
                // Odd length: reverse all but the last char of first_half_str
                // The last char of first_half_str is the middle char of the palindrome
                let second_half = first_half_str[..first_half_str.len() - 1].chars().rev().collect::<String>();
                palindrome_str.push_str(&second_half);
            }

            results.push(palindrome_str.parse::<i64>().unwrap());
        }

        results
    }
}