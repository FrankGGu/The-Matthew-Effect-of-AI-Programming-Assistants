impl Solution {
    pub fn min_operations(boxes: String) -> Vec<i32> {
        let boxes: Vec<char> = boxes.chars().collect();
        let n = boxes.len();
        let mut res = vec![0; n];
        let (mut left, mut right, mut operations) = (0, 0, 0);

        for i in 1..n {
            if boxes[i - 1] == '1' {
                left += 1;
            }
            operations += left;
            res[i] += operations;
        }

        operations = 0;
        for i in (0..n - 1).rev() {
            if boxes[i + 1] == '1' {
                right += 1;
            }
            operations += right;
            res[i] += operations;
        }

        res
    }
}