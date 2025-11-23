use std::collections::VecDeque;

impl Solution {
    pub fn find_max_value_of_equation(points: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut deque: VecDeque<(i32, i32)> = VecDeque::new();
        let mut max_value = i32::MIN;

        for point in &points {
            let x = point[0];
            let y = point[1];

            while !deque.is_empty() && x - deque.front().unwrap().0 > k {
                deque.pop_front();
            }

            if !deque.is_empty() {
                max_value = max_value.max(x + y + deque.front().unwrap().1);
            }

            while !deque.is_empty() && y - x >= deque.back().unwrap().1 {
                deque.pop_back();
            }

            deque.push_back((x, y - x));
        }

        max_value
    }
}