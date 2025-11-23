use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn brace_expansion_ii(expression: String) -> Vec<String> {
        let chars: Vec<char> = expression.chars().collect();
        let mut pos = 0;
        let result = Self::parse_expression(&chars, &mut pos);
        let mut sorted_result: Vec<String> = result.into_iter().collect();
        sorted_result.sort_unstable();
        sorted_result
    }

    fn parse_expression(chars: &[char], pos: &mut usize) -> HashSet<String> {
        let mut current_set = Self::parse_term(chars, pos);

        while *pos < chars.len() && chars[*pos] == ',' {
            *pos += 1;
            let next_term_set = Self::parse_term(chars, pos);
            current_set.extend(next_term_set);
        }
        current_set
    }

    fn parse_term(chars: &[char], pos: &mut usize) -> HashSet<String> {
        let mut current_set = Self::parse_factor(chars, pos);

        while *pos < chars.len() && chars[*pos] != '}' && chars[*pos] != ',' {
            let next_factor_set = Self::parse_factor(chars, pos);
            let mut new_set = HashSet::new();
            for s1 in current_set.iter() {
                for s2 in next_factor_set.iter() {
                    new_set.insert(format!("{}{}", s1, s2));
                }
            }
            current_set = new_set;
        }
        current_set
    }

    fn parse_factor(chars: &[char], pos: &mut usize) -> HashSet<String> {
        let mut set = HashSet::new();

        if chars[*pos] == '{' {
            *pos += 1;
            set = Self::parse_expression(chars, pos);
            *pos += 1;
        } else {
            set.insert(chars[*pos].to_string());
            *pos += 1;
        }
        set
    }
}