use std::collections::VecDeque;

impl Solution {
    pub fn find_max_value_of_equation(points: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut deque = VecDeque::new();
        let mut max_value = std::i32::MIN;

        for j in 0..points.len() {
            let xj = points[j][0];
            let yj = points[j][1];

            while !deque.is_empty() && xj - points[deque[0]][0] > k {
                deque.pop_front();
            }

            if !deque.is_empty() {
                let i = deque[0];
                let xi = points[i][0];
                let yi = points[i][1];
                max_value = max_value.max(yi + yj + xj - xi);
            }

            while !deque.is_empty() {
                let last = *deque.back().unwrap();
                let x_last = points[last][0];
                let y_last = points[last][1];
                if yj - xj >= y_last - x_last {
                    deque.pop_back();
                } else {
                    break;
                }
            }

            deque.push_back(j);
        }

        max_value
    }
}