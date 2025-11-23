impl Solution {

use std::vec::Vec;

struct Solution {}

impl Solution {
    pub fn restore_ip_addresses(s: String) -> Vec<String> {
        let mut result = Vec::new();
        let s_len = s.len();
        if s_len < 4 || s_len > 12 {
            return result;
        }
        let s_bytes = s.as_bytes();
        for i in 1..=3 {
            if i >= s_len {
                break;
            }
            let first = &s[0..i];
            if first.len() > 1 && first.starts_with('0') {
                continue;
            }
            if first.parse::<u8>().unwrap() > 255 {
                continue;
            }
            for j in i + 1..=i + 3 {
                if j >= s_len {
                    break;
                }
                let second = &s[i..j];
                if second.len() > 1 && second.starts_with('0') {
                    continue;
                }
                if second.parse::<u8>().unwrap() > 255 {
                    continue;
                }
                for k in j + 1..=j + 3 {
                    if k >= s_len {
                        break;
                    }
                    let third = &s[j..k];
                    if third.len() > 1 && third.starts_with('0') {
                        continue;
                    }
                    if third.parse::<u8>().unwrap() > 255 {
                        continue;
                    }
                    let fourth = &s[k..];
                    if fourth.len() > 1 && fourth.starts_with('0') {
                        continue;
                    }
                    if fourth.parse::<u8>().unwrap() > 255 {
                        continue;
                    }
                    result.push(format!("{}.{}.{}.{}", first, second, third, fourth));
                }
            }
        }
        result
    }
}
}