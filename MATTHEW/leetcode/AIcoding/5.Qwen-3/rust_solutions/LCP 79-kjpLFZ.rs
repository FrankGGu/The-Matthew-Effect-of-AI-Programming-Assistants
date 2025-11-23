impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn get_frequency_dict(s: &str) -> HashMap<char, i32> {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }
        freq
    }

    pub fn is_possible(s: &str, t: &str) -> bool {
        if s.len() != t.len() {
            return false;
        }
        let s_freq = Self::get_frequency_dict(s);
        let t_freq = Self::get_frequency_dict(t);
        s_freq == t_freq
    }

    pub fn find_original_string(s: &str) -> String {
        let mut result = String::new();
        let mut seen = HashMap::new();
        let mut current = String::new();
        let mut count = 0;

        for c in s.chars() {
            if c == '(' {
                count += 1;
                if count == 1 {
                    current.clear();
                } else {
                    current.push(c);
                }
            } else if c == ')' {
                count -= 1;
                if count == 0 {
                    let key = current.clone();
                    let value = seen.entry(key).or_insert(0);
                    *value += 1;
                    current.clear();
                } else {
                    current.push(c);
                }
            } else {
                if count == 0 {
                    result.push(c);
                } else {
                    current.push(c);
                }
            }
        }

        let mut chars: Vec<char> = result.chars().collect();
        let mut freq = HashMap::new();

        for c in &chars {
            *freq.entry(*c).or_insert(0) += 1;
        }

        let mut sorted_chars: Vec<(char, i32)> = freq.into_iter().collect();
        sorted_chars.sort_by(|a, b| b.1.cmp(&a.1));

        let mut result_str = String::new();
        for (c, _) in sorted_chars {
            result_str.push(c);
        }

        result_str
    }

    pub fn original_digits(s: &str) -> String {
        let mut result = String::new();
        let mut seen = HashMap::new();
        let mut current = String::new();
        let mut count = 0;

        for c in s.chars() {
            if c == '(' {
                count += 1;
                if count == 1 {
                    current.clear();
                } else {
                    current.push(c);
                }
            } else if c == ')' {
                count -= 1;
                if count == 0 {
                    let key = current.clone();
                    let value = seen.entry(key).or_insert(0);
                    *value += 1;
                    current.clear();
                } else {
                    current.push(c);
                }
            } else {
                if count == 0 {
                    result.push(c);
                } else {
                    current.push(c);
                }
            }
        }

        let mut chars: Vec<char> = result.chars().collect();
        let mut freq = HashMap::new();

        for c in &chars {
            *freq.entry(*c).or_insert(0) += 1;
        }

        let mut sorted_chars: Vec<(char, i32)> = freq.into_iter().collect();
        sorted_chars.sort_by(|a, b| b.1.cmp(&a.1));

        let mut result_str = String::new();
        for (c, _) in sorted_chars {
            result_str.push(c);
        }

        result_str
    }

    pub fn find_original_string_with_repeats(s: &str) -> String {
        let mut result = String::new();
        let mut seen = HashMap::new();
        let mut current = String::new();
        let mut count = 0;

        for c in s.chars() {
            if c == '(' {
                count += 1;
                if count == 1 {
                    current.clear();
                } else {
                    current.push(c);
                }
            } else if c == ')' {
                count -= 1;
                if count == 0 {
                    let key = current.clone();
                    let value = seen.entry(key).or_insert(0);
                    *value += 1;
                    current.clear();
                } else {
                    current.push(c);
                }
            } else {
                if count == 0 {
                    result.push(c);
                } else {
                    current.push(c);
                }
            }
        }

        let mut chars: Vec<char> = result.chars().collect();
        let mut freq = HashMap::new();

        for c in &chars {
            *freq.entry(*c).or_insert(0) += 1;
        }

        let mut sorted_chars: Vec<(char, i32)> = freq.into_iter().collect();
        sorted_chars.sort_by(|a, b| b.1.cmp(&a.1));

        let mut result_str = String::new();
        for (c, _) in sorted_chars {
            result_str.push(c);
        }

        result_str
    }

    pub fn extract_spell(s: &str) -> String {
        let mut result = String::new();
        let mut seen = HashMap::new();
        let mut current = String::new();
        let mut count = 0;

        for c in s.chars() {
            if c == '(' {
                count += 1;
                if count == 1 {
                    current.clear();
                } else {
                    current.push(c);
                }
            } else if c == ')' {
                count -= 1;
                if count == 0 {
                    let key = current.clone();
                    let value = seen.entry(key).or_insert(0);
                    *value += 1;
                    current.clear();
                } else {
                    current.push(c);
                }
            } else {
                if count == 0 {
                    result.push(c);
                } else {
                    current.push(c);
                }
            }
        }

        let mut chars: Vec<char> = result.chars().collect();
        let mut freq = HashMap::new();

        for c in &chars {
            *freq.entry(*c).or_insert(0) += 1;
        }

        let mut sorted_chars: Vec<(char, i32)> = freq.into_iter().collect();
        sorted_chars.sort_by(|a, b| b.1.cmp(&a.1));

        let mut result_str = String::new();
        for (c, _) in sorted_chars {
            result_str.push(c);
        }

        result_str
    }
}
}