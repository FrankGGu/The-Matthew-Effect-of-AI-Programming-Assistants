use std::collections::HashSet;

impl Solution {
    pub fn remove_invalid_parentheses(s: String) -> Vec<String> {
        let mut result = HashSet::new();
        let mut min_removed = std::i32::MAX;
        Self::backtrack(&s, 0, 0, 0, 0, &mut String::new(), &mut result, &mut min_removed);
        result.into_iter().collect()
    }

    fn backtrack(
        s: &str,
        index: usize,
        left_count: i32,
        right_count: i32,
        removed: i32,
        current: &mut String,
        result: &mut HashSet<String>,
        min_removed: &mut i32,
    ) {
        if index == s.len() {
            if left_count == right_count {
                if removed < *min_removed {
                    result.clear();
                    *min_removed = removed;
                }
                if removed == *min_removed {
                    result.insert(current.clone());
                }
            }
            return;
        }

        let c = s.chars().nth(index).unwrap();
        if c != '(' && c != ')' {
            current.push(c);
            Self::backtrack(
                s,
                index + 1,
                left_count,
                right_count,
                removed,
                current,
                result,
                min_removed,
            );
            current.pop();
        } else {
            Self::backtrack(
                s,
                index + 1,
                left_count,
                right_count,
                removed + 1,
                current,
                result,
                min_removed,
            );

            current.push(c);
            if c == '(' {
                Self::backtrack(
                    s,
                    index + 1,
                    left_count + 1,
                    right_count,
                    removed,
                    current,
                    result,
                    min_removed,
                );
            } else if right_count < left_count {
                Self::backtrack(
                    s,
                    index + 1,
                    left_count,
                    right_count + 1,
                    removed,
                    current,
                    result,
                    min_removed,
                );
            }
            current.pop();
        }
    }
}