impl Solution {
    pub fn is_valid(s: String) -> bool {
        let mut stack = Vec::new();
        let map = [('(', ')'), ('{', '}'), ('[', ']')].iter().cloned().collect::<std::collections::HashMap<_, _>>();

        for c in s.chars() {
            if map.contains_key(&c) {
                stack.push(c);
            } else if let Some(&open) = map.iter().find_map(|(&k, &v)| if v == c { Some(k) } else { None }) {
                if stack.pop() != Some(open) {
                    return false;
                }
            }
        }
        stack.is_empty()
    }
}