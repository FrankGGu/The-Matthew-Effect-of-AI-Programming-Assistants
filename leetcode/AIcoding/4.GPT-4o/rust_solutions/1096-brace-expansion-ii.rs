use std::collections::HashSet;

impl Solution {
    pub fn brace_expansion_ii(expression: String) -> Vec<String> {
        fn expand(expr: &str) -> Vec<String> {
            let mut result = vec![];
            let mut parts = vec![];
            let mut current = String::new();
            let mut in_brace = false;

            for c in expr.chars() {
                match c {
                    '{' => {
                        if !current.is_empty() {
                            parts.push(current.clone());
                            current.clear();
                        }
                        in_brace = true;
                    }
                    '}' => {
                        if !current.is_empty() {
                            parts.push(current.clone());
                            current.clear();
                        }
                        in_brace = false;
                        let mut new_parts = vec![];
                        for part in parts.iter() {
                            for item in part.split(',') {
                                new_parts.push(item.to_string());
                            }
                        }
                        parts = new_parts;
                    }
                    ',' => {
                        if in_brace {
                            if !current.is_empty() {
                                parts.push(current.clone());
                                current.clear();
                            }
                        } else {
                            if !current.is_empty() {
                                result.append(&mut expand(&current));
                                current.clear();
                            }
                        }
                    }
                    _ => current.push(c),
                }
            }
            if !current.is_empty() {
                parts.push(current);
            }
            if in_brace {
                let mut new_parts = vec![];
                for part in parts.iter() {
                    for item in part.split(',') {
                        new_parts.push(item.to_string());
                    }
                }
                parts = new_parts;
            }
            let mut res = HashSet::new();
            for part in parts {
                res.insert(part);
            }
            res.into_iter().collect()
        }

        let parts = expression.split(',').collect::<Vec<&str>>();
        let mut result = vec![];
        for part in parts {
            let mut expanded = expand(part);
            result.append(&mut expanded);
        }
        let mut final_result: HashSet<String> = HashSet::new();
        for item in result {
            final_result.insert(item);
        }
        let mut final_vec: Vec<String> = final_result.into_iter().collect();
        final_vec.sort();
        final_vec
    }
}