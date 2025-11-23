impl Solution {
    pub fn find_lex_smallest_string(s: String, k: i32) -> String {
        let k = k as usize;
        let s = s.chars().collect::<Vec<_>>();
        let n = s.len();
        let mut visited = std::collections::HashSet::new();
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(s.clone());
        visited.insert(s.clone());
        let mut res = s.clone();

        while let Some(current) = queue.pop_front() {
            if current < res {
                res = current.clone();
            }

            let mut next = current.clone();
            for i in (1..n).step_by(2) {
                let digit = next[i].to_digit(10).unwrap() as u8;
                next[i] = std::char::from_digit((digit + k as u8) % 10, 10).unwrap();
            }
            if visited.insert(next.clone()) {
                queue.push_back(next);
            }

            let next_swapped = {
                let mut temp = current.clone();
                temp.rotate_left(k);
                temp
            };
            if visited.insert(next_swapped.clone()) {
                queue.push_back(next_swapped);
            }
        }

        res.into_iter().collect()
    }
}