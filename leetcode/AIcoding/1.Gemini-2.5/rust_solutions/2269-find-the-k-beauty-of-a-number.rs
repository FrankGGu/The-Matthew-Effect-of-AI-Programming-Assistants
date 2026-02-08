impl Solution {
    pub fn divisor_substrings(num: i32, k: i32) -> i32 {
        let s = num.to_string();
        let k_usize = k as usize;
        let mut count = 0;

        for i in 0..=s.len() - k_usize {
            let sub_str = &s[i..i + k_usize];
            if let Ok(sub_num) = sub_str.parse::<i32>() {
                if sub_num != 0 && num % sub_num == 0 {
                    count += 1;
                }
            }
        }
        count
    }
}