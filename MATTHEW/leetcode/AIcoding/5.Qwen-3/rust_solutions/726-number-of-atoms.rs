impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_atoms(mut formula: String) -> String {
        let mut stack = vec![HashMap::new()];
        let mut i = 0;
        let chars: Vec<char> = formula.chars().collect();
        let n = chars.len();

        while i < n {
            match chars[i] {
                '(' => {
                    stack.push(HashMap::new());
                    i += 1;
                },
                ')' => {
                    let mut temp = HashMap::new();
                    let mut count = 0;
                    let mut j = i + 1;
                    while j < n && chars[j].is_ascii_digit() {
                        count = count * 10 + (chars[j] as u8 - b'0') as usize;
                        j += 1;
                    }
                    if count == 0 {
                        count = 1;
                    }
                    let mut current = stack.pop().unwrap();
                    for (k, v) in current.iter() {
                        *temp.entry(k.clone()).or_insert(0) += v * count;
                    }
                    let last = stack.last_mut().unwrap();
                    for (k, v) in temp.iter() {
                        *last.entry(k.clone()).or_insert(0) += v;
                    }
                    i = j;
                },
                _ => {
                    let mut name = chars[i];
                    i += 1;
                    while i < n && chars[i].is_lowercase() {
                        name = chars[i];
                        i += 1;
                    }
                    let mut count = 0;
                    while i < n && chars[i].is_ascii_digit() {
                        count = count * 10 + (chars[i] as u8 - b'0') as usize;
                        i += 1;
                    }
                    if count == 0 {
                        count = 1;
                    }
                    let last = stack.last_mut().unwrap();
                    *last.entry(name).or_insert(0) += count;
                }
            }
        }

        let mut result = HashMap::new();
        for h in stack {
            for (k, v) in h.iter() {
                *result.entry(k.clone()).or_insert(0) += v;
            }
        }

        let mut sorted: Vec<_> = result.into_iter().collect();
        sorted.sort_by(|a, b| a.0.cmp(&b.0));

        let mut res = String::new();
        for (name, count) in sorted {
            res.push_str(&name);
            if count > 1 {
                res.push_str(&count.to_string());
            }
        }

        res
    }
}
}