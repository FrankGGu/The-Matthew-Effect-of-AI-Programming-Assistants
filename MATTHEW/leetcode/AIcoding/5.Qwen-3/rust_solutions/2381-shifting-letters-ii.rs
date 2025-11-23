impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn shifting_letters(s: String, shifts: Vec<Vec<i32>>) -> String {
        let mut res = vec!['a'; s.len()];
        let mut shift = 0;
        let mut queue = VecDeque::new();

        for i in 0..shifts.len() {
            queue.push_back((shifts[i][0] as usize, shifts[i][1] as i32));
        }

        for i in (0..s.len()).rev() {
            while let Some(&(pos, val)) = queue.front() {
                if pos == i {
                    shift += val;
                    queue.pop_front();
                } else {
                    break;
                }
            }
            shift %= 26;
            res[i] = ((s.as_bytes()[i] - b'a') as i32 + shift) % 26 + b'a' as i32;
        }

        res.iter().map(|&c| c as char).collect()
    }
}
}