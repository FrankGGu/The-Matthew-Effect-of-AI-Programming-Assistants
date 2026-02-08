use std::collections::VecDeque;

impl Solution {
    pub fn max_value_of_equation(points: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut max_val: i64 = i64::MIN;
        // The deque stores pairs of (yi - xi, xi).
        // It maintains a monotonically decreasing sequence of (yi - xi) values.
        // The xi values are strictly increasing, so the front of the deque will have
        // the largest (yi - xi) for the smallest xi within the valid window.
        let mut deque: VecDeque<(i64, i32)> = VecDeque::new();

        for point in points {
            let xj = point[0];
            let yj = point[1];

            // 1. Remove points from the front of the deque that are no longer valid.
            // A point (xi, yi) is invalid if xj - xi > k, which means xi < xj - k.
            while let Some((_, xi_prev)) = deque.front() {
                if *xi_prev < xj - k {
                    deque.pop_front();
                } else {
                    break; // The deque is ordered by xi, so if the front is valid, others are too.
                }
            }

            // 2. If the deque is not empty, calculate the potential maximum using the best available 'i'.
            // The front of the deque contains the (yi - xi) with the maximum value for a valid xi.
            if let Some((yi_minus_xi, _)) = deque.front() {
                // The equation is (yi - xi) + (yj + xj)
                let current_sum = yi_minus_xi + (yj as i64 + xj as i64);
                max_val = max_val.max(current_sum);
            }

            // 3. Add the current point (xj, yj) to the deque.
            // Before adding, remove elements from the back whose (yi - xi) value is less than or equal to
            // the current point's (yj - xj). This maintains the monotonic decreasing property.
            let yj_minus_xj = yj as i64 - xj as i64;
            while let Some((yi_minus_xi_back, _)) = deque.back() {
                if *yi_minus_xi_back <= yj_minus_xj {
                    deque.pop_back();
                } else {
                    break;
                }
            }
            deque.push_back((yj_minus_xj, xj));
        }

        // The problem implies the result fits in i32, so cast the i64 max_val.
        max_val as i32
    }
}