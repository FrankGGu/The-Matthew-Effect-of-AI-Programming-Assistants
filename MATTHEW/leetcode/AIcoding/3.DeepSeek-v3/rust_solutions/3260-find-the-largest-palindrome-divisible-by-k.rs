impl Solution {
    pub fn largest_palindromic(num: String) -> String {
        let mut count = vec![0; 10];
        for c in num.chars() {
            let digit = c.to_digit(10).unwrap() as usize;
            count[digit] += 1;
        }

        let mut half = Vec::new();
        let mut mid = None;

        for d in (0..=9).rev() {
            if count[d] == 0 {
                continue;
            }
            if count[d] % 2 == 1 && mid.is_none() {
                mid = Some(d);
            }
            for _ in 0..count[d] / 2 {
                half.push(d as u8 + b'0');
            }
        }

        if half.is_empty() {
            if let Some(m) = mid {
                return m.to_string();
            } else {
                return "0".to_string();
            }
        }

        if half[0] == b'0' {
            if let Some(m) = mid {
                return m.to_string();
            } else {
                return "0".to_string();
            }
        }

        let mut res = half.clone();
        if let Some(m) = mid {
            res.push(m as u8 + b'0');
        }
        half.reverse();
        res.extend(half);

        String::from_utf8(res).unwrap()
    }
}