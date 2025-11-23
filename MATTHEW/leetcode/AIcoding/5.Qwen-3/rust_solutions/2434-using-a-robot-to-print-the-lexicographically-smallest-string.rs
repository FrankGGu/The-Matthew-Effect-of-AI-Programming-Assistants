struct Solution {}

impl Solution {
    pub fn robot_string(s: String) -> String {
        let mut stack = Vec::new();
        let mut result = Vec::new();
        let mut count = std::collections::HashMap::new();

        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        for c in s.chars() {
            *count.get_mut(&c).unwrap() -= 1;
            if c == 'a' {
                while let Some(top) = stack.last() {
                    if *top == 'a' {
                        break;
                    }
                    if count[top] > 0 {
                        break;
                    }
                    result.push(stack.pop().unwrap());
                }
            }
            stack.push(c);
        }

        while let Some(c) = stack.pop() {
            result.push(c);
        }

        result.into_iter().collect()
    }
}