impl Solution {
    pub fn kth_palindrome(queries: Vec<i32>, int_length: i32) -> Vec<i64> {
        let len = int_length as i64;
        let half_len = (int_length + 1) / 2 as i32;
        let start = 10_i64.pow((half_len - 1) as u32);
        let count = 9 * 10_i64.pow((half_len - 1) as u32);

        queries.iter().map(|&q| {
            if q as i64 > count {
                -1
            } else {
                let num = start + q as i64 - 1;
                let mut s = num.to_string();
                let mut t = s.clone();
                if int_length % 2 == 0 {
                    t = t.chars().rev().collect::<String>();
                } else {
                    t = t.chars().skip(1).rev().collect::<String>();
                }
                s.push_str(&t);
                s.parse::<i64>().unwrap()
            }
        }).collect()
    }
}