impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn strong_password_checker(password: String) -> i32 {
        let mut n = password.len();
        let mut missing = 0;
        if n < 6 {
            return 6 - n;
        }

        let mut has_lower = false;
        let mut has_upper = false;
        let mut has_digit = false;

        for c in password.chars() {
            if c.is_lowercase() {
                has_lower = true;
            } else if c.is_uppercase() {
                has_upper = true;
            } else if c.is_digit(10) {
                has_digit = true;
            }
        }

        missing = 3 - (has_lower as i32 + has_upper as i32 + has_digit as i32);

        if n <= 8 {
            return missing.max(6 - n);
        }

        let mut replace = 0;
        let mut freq = HashMap::new();

        let mut i = 0;
        while i < n {
            let mut j = i;
            while j < n && password.chars().nth(j) == password.chars().nth(i) {
                j += 1;
            }
            let len = j - i;
            if len >= 3 {
                *freq.entry(len % 3).or_insert(0) += 1;
                replace += len / 3;
            }
            i = j;
        }

        let mut res = 0;

        if n > 20 {
            let mut remove = n - 20;
            let mut i = 0;

            while remove > 0 && i < 3 {
                if let Some(&count) = freq.get(&i) {
                    let take = (remove / (i + 1)).min(count);
                    res += take * (i + 1);
                    remove -= take * (i + 1);
                    *freq.get_mut(&i).unwrap() -= take;
                    if i == 0 {
                        freq.insert(2, *freq.get(&i).unwrap());
                    }
                }
                i += 1;
            }

            if remove > 0 {
                let mut count = 0;
                for &k in freq.keys() {
                    count += freq[&k];
                }
                res += remove;
                replace -= count;
            }

            res += replace;
            return res + missing;
        } else {
            return replace.max(missing);
        }
    }
}
}