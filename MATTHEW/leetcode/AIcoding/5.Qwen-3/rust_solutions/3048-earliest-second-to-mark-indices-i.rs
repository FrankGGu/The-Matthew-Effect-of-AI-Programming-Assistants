impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn earliest_second(s: String, target: String) -> i32 {
        let s_bytes = s.as_bytes();
        let target_bytes = target.as_bytes();
        let mut queue = VecDeque::new();
        let mut positions = vec![0; 256];

        for (i, &c) in s_bytes.iter().enumerate() {
            positions[c as usize] = i;
        }

        for (i, &c) in target_bytes.iter().enumerate() {
            if positions[c as usize] == 0 && i > 0 {
                return -1;
            }
            queue.push_back(positions[c as usize]);
        }

        let mut result = 0;
        let mut current = 0;

        while let Some(pos) = queue.pop_front() {
            if pos < current {
                return -1;
            }
            result = pos - current + 1;
            current = pos + 1;
        }

        result
    }
}
}