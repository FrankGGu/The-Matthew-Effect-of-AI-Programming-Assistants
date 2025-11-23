impl Solution {
    pub fn smallest_subsequence(s: String) -> String {
        let mut last_occurrence = vec![0; 26];
        for (i, c) in s.chars().enumerate() {
            last_occurrence[c as usize - 'a' as usize] = i;
        }

        let mut stack = Vec::new();
        let mut in_stack = vec![false; 26];

        for (i, c) in s.chars().enumerate() {
            let index = c as usize - 'a' as usize;
            if in_stack[index] {
                continue;
            }
            while let Some(&top) = stack.last() {
                if top > c && last_occurrence[top as usize - 'a' as usize] > i {
                    in_stack[top as usize - 'a' as usize] = false;
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(c);
            in_stack[index] = true;
        }

        stack.iter().collect()
    }
}