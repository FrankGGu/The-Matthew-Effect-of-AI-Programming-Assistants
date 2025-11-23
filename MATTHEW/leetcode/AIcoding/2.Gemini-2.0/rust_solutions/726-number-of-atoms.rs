use std::collections::HashMap;

impl Solution {
    pub fn count_of_atoms(formula: String) -> String {
        let mut stack: Vec<HashMap<String, i32>> = Vec::new();
        stack.push(HashMap::new());
        let mut i = 0;
        let chars: Vec<char> = formula.chars().collect();

        while i < chars.len() {
            let c = chars[i];
            if c == '(' {
                stack.push(HashMap::new());
                i += 1;
            } else if c == ')' {
                i += 1;
                let mut num_str = String::new();
                while i < chars.len() && chars[i].is_digit(10) {
                    num_str.push(chars[i]);
                    i += 1;
                }
                let num: i32 = if num_str.is_empty() { 1 } else { num_str.parse().unwrap() };

                let top = stack.pop().unwrap();
                for (atom, count) in top {
                    *stack.last_mut().unwrap().entry(atom).or_insert(0) += count * num;
                }
            } else {
                let mut atom_str = String::new();
                atom_str.push(c);
                i += 1;
                while i < chars.len() && chars[i].is_lowercase() {
                    atom_str.push(chars[i]);
                    i += 1;
                }

                let mut num_str = String::new();
                while i < chars.len() && chars[i].is_digit(10) {
                    num_str.push(chars[i]);
                    i += 1;
                }
                let num: i32 = if num_str.is_empty() { 1 } else { num_str.parse().unwrap() };

                *stack.last_mut().unwrap().entry(atom_str).or_insert(0) += num;
            }
        }

        let mut result: Vec<(String, i32)> = stack.pop().unwrap().into_iter().collect();
        result.sort_by(|a, b| a.0.cmp(&b.0));

        let mut ans = String::new();
        for (atom, count) in result {
            ans.push_str(&atom);
            if count > 1 {
                ans.push_str(&count.to_string());
            }
        }

        ans
    }
}