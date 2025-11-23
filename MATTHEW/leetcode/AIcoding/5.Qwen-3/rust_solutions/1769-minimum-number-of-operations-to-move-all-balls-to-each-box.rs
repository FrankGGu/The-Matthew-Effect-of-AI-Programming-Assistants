impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_operations(boxes: String) -> Vec<i32> {
        let n = boxes.len();
        let mut res = vec![0; n];
        let mut left = vec![0; n];
        let mut right = vec![0; n];

        let mut count = 0;
        for i in 0..n {
            left[i] = count;
            if boxes.as_bytes()[i] == b'1' {
                count += 1;
            }
        }

        count = 0;
        for i in (0..n).rev() {
            right[i] = count;
            if boxes.as_bytes()[i] == b'1' {
                count += 1;
            }
        }

        for i in 0..n {
            res[i] = left[i] + right[i];
        }

        res
    }
}
}