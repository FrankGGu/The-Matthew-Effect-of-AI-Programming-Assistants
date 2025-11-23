use std::collections::HashSet;

impl Solution {
    pub fn brace_expansion_ii(expression: String) -> Vec<String> {
        let mut set = Self::evaluate(&expression);
        let mut result: Vec<String> = set.into_iter().collect();
        result.sort();
        result
    }

    fn evaluate(expression: &str) -> HashSet<String> {
        let mut set = HashSet::new();
        let mut i = 0;
        let chars: Vec<char> = expression.chars().collect();

        while i < chars.len() {
            if chars[i] == '{' {
                let mut count = 1;
                let mut j = i + 1;
                while j < chars.len() && count > 0 {
                    if chars[j] == '{' {
                        count += 1;
                    } else if chars[j] == '}' {
                        count -= 1;
                    }
                    j += 1;
                }

                let sub_expression = &expression[i + 1..j - 1];
                let mut options = Vec::new();
                let mut start = 0;
                let mut brace_count = 0;
                for k in 0..sub_expression.len() {
                    if sub_expression.chars().nth(k).unwrap() == '{' {
                        brace_count += 1;
                    } else if sub_expression.chars().nth(k).unwrap() == '}' {
                        brace_count -= 1;
                    } else if sub_expression.chars().nth(k).unwrap() == ',' && brace_count == 0 {
                        options.push(&sub_expression[start..k]);
                        start = k + 1;
                    }
                }
                options.push(&sub_expression[start..]);

                let mut current_set = HashSet::new();
                for option in options {
                    let option_set = Self::evaluate(option);
                    for s in option_set {
                        current_set.insert(s);
                    }
                }

                if !set.is_empty() {
                    let mut new_set = HashSet::new();
                    for s1 in &set {
                        for s2 in &current_set {
                            new_set.insert(s1.clone() + &s2.clone());
                        }
                    }
                    set = new_set;
                } else {
                    set = current_set;
                }

                i = j;
            } else {
                let mut j = i;
                while j < chars.len() && chars[j] != '{' && chars[j] != ',' && chars[j] != '}' {
                    j += 1;
                }

                let word = &expression[i..j];
                if !set.is_empty() {
                    let mut new_set = HashSet::new();
                    for s in &set {
                        new_set.insert(s.clone() + word);
                    }
                    set = new_set;
                } else {
                    set.insert(word.to_string());
                }
                i = j;
            }
        }

        set
    }
}