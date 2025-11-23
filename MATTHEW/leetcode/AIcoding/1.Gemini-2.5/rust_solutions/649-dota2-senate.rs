use std::collections::VecDeque;

impl Solution {
    pub fn predict_party_victory(senate: String) -> String {
        let n = senate.len();
        let mut radiant_queue: VecDeque<usize> = VecDeque::new();
        let mut dire_queue: VecDeque<usize> = VecDeque::new();

        for (i, c) in senate.chars().enumerate() {
            if c == 'R' {
                radiant_queue.push_back(i);
            } else {
                dire_queue.push_back(i);
            }
        }

        while !radiant_queue.is_empty() && !dire_queue.is_empty() {
            let r_idx = radiant_queue.pop_front().unwrap();
            let d_idx = dire_queue.pop_front().unwrap();

            if r_idx < d_idx {
                radiant_queue.push_back(r_idx + n);
            } else {
                dire_queue.push_back(d_idx + n);
            }
        }

        if radiant_queue.is_empty() {
            "Dire".to_string()
        } else {
            "Radiant".to_string()
        }
    }
}