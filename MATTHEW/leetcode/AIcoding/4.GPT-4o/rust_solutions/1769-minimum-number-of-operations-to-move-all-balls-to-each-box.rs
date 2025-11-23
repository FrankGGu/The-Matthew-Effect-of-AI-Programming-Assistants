impl Solution {
    pub fn min_operations(boxes: String) -> Vec<i32> {
        let n = boxes.len();
        let mut result = vec![0; n];
        let mut left_sum = 0;
        let mut right_sum = 0;
        let mut left_count = 0;
        let mut right_count = 0;

        for i in 0..n {
            if boxes.chars().nth(i).unwrap() == '1' {
                right_count += 1;
                right_sum += i as i32;
            }
        }

        for i in 0..n {
            result[i] = left_sum + right_sum;
            if boxes.chars().nth(i).unwrap() == '1' {
                left_count += 1;
                right_count -= 1;
                left_sum += left_count as i32;
                right_sum -= right_count as i32;
            }
        }

        result
    }
}