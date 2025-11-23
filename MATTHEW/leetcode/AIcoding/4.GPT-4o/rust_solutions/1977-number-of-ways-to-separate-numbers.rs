impl Solution {
    pub fn separate_numbers(s: String) -> String {
        let n = s.len();
        for len in 1..=(n / 2) {
            if n % len == 0 {
                let mut valid = true;
                let mut current = String::new();
                let mut start = 0;
                let mut num = s[start..start + len].to_string();
                while start < n {
                    current.push_str(&num);
                    start += num.len();
                    if start < n {
                        let next_num = (num.parse::<u64>().unwrap() + 1).to_string();
                        if s[start..start + next_num.len()] != next_num {
                            valid = false;
                            break;
                        }
                        num = next_num;
                    }
                }
                if valid {
                    return format!("Yes {}", &s[..len]);
                }
            }
        }
        "No".to_string()
    }
}