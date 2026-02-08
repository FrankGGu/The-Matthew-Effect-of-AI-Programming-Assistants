impl Solution {
    pub fn min_operations(boxes: String) -> Vec<i32> {
        let n = boxes.len();
        let mut result = vec![0; n];
        let boxes_chars: Vec<char> = boxes.chars().collect();

        for i in 0..n {
            for j in 0..n {
                if boxes_chars[j] == '1' {
                    result[i] += (i as i32 - j as i32).abs();
                }
            }
        }

        result
    }
}