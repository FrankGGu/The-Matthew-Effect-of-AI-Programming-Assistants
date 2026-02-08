impl Solution {
    pub fn find_lex_smallest_string(s: String, a: i32, b: i32) -> String {
        use std::collections::HashSet;
        let mut visited = HashSet::new();
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(s.clone());
        visited.insert(s);
        let mut min_str = s;
        while let Some(current) = queue.pop_front() {
            if current < min_str {
                min_str = current.clone();
            }
            let s_bytes = current.as_bytes();
            let len = s_bytes.len();

            // Operation 1: Add a to every odd index
            let mut op1 = s_bytes.to_vec();
            for i in (1..len).step_by(2) {
                let digit = (op1[i] - b'0') as i32;
                let new_digit = (digit + a) % 10;
                op1[i] = (new_digit as u8) + b'0';
            }
            let op1_str = String::from_utf8(op1).unwrap();
            if !visited.contains(&op1_str) {
                visited.insert(op1_str.clone());
                queue.push_back(op1_str);
            }

            // Operation 2: Rotate b positions right
            let rotate_pos = (len as i32 - b) as usize % len;
            let op2_str = format!("{}{}", &current[rotate_pos..], &current[..rotate_pos]);
            if !visited.contains(&op2_str) {
                visited.insert(op2_str.clone());
                queue.push_back(op2_str);
            }
        }
        min_str
    }
}