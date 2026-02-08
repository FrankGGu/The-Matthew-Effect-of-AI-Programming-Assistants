impl Solution {
    pub fn min_remove_to_make_valid(s: String) -> String {
        let mut stack = vec![];
        let mut to_remove = vec![false; s.len()];

        for (i, c) in s.chars().enumerate() {
            if c == '(' {
                stack.push(i);
            } else if c == ')' {
                if let Some(j) = stack.pop() {
                    to_remove[j] = true;
                    to_remove[i] = true;
                }
            }
        }

        s.chars()
            .enumerate()
            .filter_map(|(i, c)| {
                if to_remove[i] {
                    None
                } else {
                    Some(c)
                }
            })
            .collect()
    }
}