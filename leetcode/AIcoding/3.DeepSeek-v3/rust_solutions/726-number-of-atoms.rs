use std::collections::BTreeMap;

impl Solution {
    pub fn count_of_atoms(formula: String) -> String {
        let mut stack: Vec<BTreeMap<String, i32>> = Vec::new();
        stack.push(BTreeMap::new());
        let mut i = 0;
        let n = formula.len();
        let chars: Vec<char> = formula.chars().collect();

        while i < n {
            if chars[i] == '(' {
                stack.push(BTreeMap::new());
                i += 1;
            } else if chars[i] == ')' {
                let top = stack.pop().unwrap();
                i += 1;
                let mut num = 0;
                while i < n && chars[i].is_ascii_digit() {
                    num = num * 10 + (chars[i] as i32 - '0' as i32);
                    i += 1;
                }
                let num = if num == 0 { 1 } else { num };
                for (k, v) in top {
                    *stack.last_mut().unwrap().entry(k).or_insert(0) += v * num;
                }
            } else {
                let mut j = i + 1;
                while j < n && chars[j].is_ascii_lowercase() {
                    j += 1;
                }
                let name = chars[i..j].iter().collect::<String>();
                i = j;
                let mut num = 0;
                while i < n && chars[i].is_ascii_digit() {
                    num = num * 10 + (chars[i] as i32 - '0' as i32);
                    i += 1;
                }
                let num = if num == 0 { 1 } else { num };
                *stack.last_mut().unwrap().entry(name).or_insert(0) += num;
            }
        }

        let map = stack.pop().unwrap();
        let mut res = String::new();
        for (k, v) in map {
            res.push_str(&k);
            if v > 1 {
                res.push_str(&v.to_string());
            }
        }
        res
    }
}