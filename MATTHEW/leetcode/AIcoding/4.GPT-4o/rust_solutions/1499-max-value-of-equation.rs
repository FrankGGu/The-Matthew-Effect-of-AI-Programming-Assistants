use std::collections::VecDeque;

pub fn find_max_value_of_equation(points: Vec<Vec<i32>>, k: i32) -> i32 {
    let mut max_value = i32::MIN;
    let mut deque = VecDeque::new();

    for (x, y) in points {
        while let Some(&(prev_x, prev_y)) = deque.front() {
            if x - prev_x > k {
                deque.pop_front();
            } else {
                break;
            }
        }

        if let Some(&(prev_x, prev_y)) = deque.front() {
            max_value = max_value.max(x + y + prev_y - prev_x);
        }

        while let Some(&(prev_x, prev_y)) = deque.back() {
            if prev_y - prev_x <= y - x {
                deque.pop_back();
            } else {
                break;
            }
        }

        deque.push_back((x, y));
    }

    max_value
}