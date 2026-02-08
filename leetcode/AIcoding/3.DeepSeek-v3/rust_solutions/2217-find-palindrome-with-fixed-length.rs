impl Solution {
    pub fn kth_palindrome(queries: Vec<i32>, int_length: i32) -> Vec<i64> {
        let half_len = (int_length as usize + 1) / 2;
        let start = 10i64.pow((half_len - 1) as u32);
        let end = 10i64.pow(half_len as u32);
        let max_num = end - start;

        queries.iter().map(|&q| {
            if q as i64 > max_num {
                -1
            } else {
                let num = start + q as i64 - 1;
                let num_str = num.to_string();
                let rev_str: String = if int_length % 2 == 0 {
                    num_str.chars().rev().collect()
                } else {
                    num_str[..num_str.len()-1].chars().rev().collect()
                };
                let palindrome_str = num_str + &rev_str;
                palindrome_str.parse().unwrap()
            }
        }).collect()
    }
}