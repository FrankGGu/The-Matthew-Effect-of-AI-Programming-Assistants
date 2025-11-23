impl Solution {
    pub fn remove_duplicate_letters(s: String) -> String {
        use std::collections::HashMap;

        let mut last_occurrence: HashMap<char, usize> = HashMap::new();
        for (i, c) in s.chars().enumerate() {
            last_occurrence.insert(c, i);
        }

        let mut stack: Vec<char> = Vec::new();
        let mut seen: std::collections::HashSet<char> = std::collections::HashSet::new();

        for (i, c) in s.chars().enumerate() {
            if seen.contains(&c) {
                continue;
            }

            while !stack.is_empty() && *stack.last().unwrap() > c && last_occurrence[&stack.last().unwrap()] > i {
                seen.remove(&stack.pop().unwrap());
            }

            stack.push(c);
            seen.insert(c);
        }

        stack.iter().collect::<String>()
    }
}