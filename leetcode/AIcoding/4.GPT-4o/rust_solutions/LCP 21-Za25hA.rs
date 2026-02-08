impl Solution {
    pub fn chase_game(positions: Vec<i32>, speed: Vec<i32>) -> Vec<i32> {
        let n = positions.len();
        let mut times: Vec<f64> = (0..n)
            .map(|i| (100.0 - positions[i] as f64) / speed[i] as f64)
            .collect();

        let mut result = vec![0; n];
        let mut stack = Vec::new();

        for i in (0..n).rev() {
            while let Some(&top) = stack.last() {
                if times[i] >= times[top] {
                    result[i] += 1;
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(i);
        }

        result
    }
}