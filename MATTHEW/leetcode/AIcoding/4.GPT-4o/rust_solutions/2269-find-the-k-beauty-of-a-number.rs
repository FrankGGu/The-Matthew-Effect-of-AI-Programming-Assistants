impl Solution {
    pub fn k_beauty_number(num: i32, k: i32) -> i32 {
        let num_str = num.to_string();
        let len = num_str.len();
        if k as usize > len {
            return 0;
        }
        let mut count = 0;
        for i in 0..=len - k as usize {
            let sub: i32 = num_str[i..i + k as usize].parse().unwrap();
            if sub % k == 0 {
                count += 1;
            }
        }
        count
    }
}