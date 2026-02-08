impl Solution {
    pub fn find_lex_smallest_string(s: String, a: i32, b: i32) -> String {
        use std::collections::HashSet;
        let mut visited = HashSet::new();
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(s.clone());
        visited.insert(s.clone());
        let mut res = s;

        while let Some(current) = queue.pop_front() {
            if current < res {
                res = current.clone();
            }

            let add_op = Self::add_op(&current, a);
            if visited.insert(add_op.clone()) {
                queue.push_back(add_op);
            }

            let rotate_op = Self::rotate_op(&current, b);
            if visited.insert(rotate_op.clone()) {
                queue.push_back(rotate_op);
            }
        }

        res
    }

    fn add_op(s: &str, a: i32) -> String {
        let a = a as u8;
        s.chars().enumerate().map(|(i, c)| {
            if i % 2 == 1 {
                let digit = c.to_digit(10).unwrap() as u8;
                let new_digit = (digit + a) % 10;
                (new_digit + b'0') as char
            } else {
                c
            }
        }).collect()
    }

    fn rotate_op(s: &str, b: i32) -> String {
        let b = b as usize;
        let n = s.len();
        let split_pos = n - b;
        let (left, right) = s.split_at(split_pos);
        format!("{}{}", right, left)
    }
}