impl Solution {
    pub fn min_operations(boxes: String) -> Vec<i32> {
        let n = boxes.len();
        let boxes_chars: Vec<char> = boxes.chars().collect();
        let mut result: Vec<i32> = vec![0; n];

        let mut left_cost = 0;
        let mut left_balls = 0;

        for i in 0..n {
            result[i] += left_cost;
            if boxes_chars[i] == '1' {
                left_balls += 1;
            }
            left_cost += left_balls;
        }

        let mut right_cost = 0;
        let mut right_balls = 0;

        for i in (0..n).rev() {
            result[i] += right_cost;
            if boxes_chars[i] == '1' {
                right_balls += 1;
            }
            right_cost += right_balls;
        }

        result
    }
}