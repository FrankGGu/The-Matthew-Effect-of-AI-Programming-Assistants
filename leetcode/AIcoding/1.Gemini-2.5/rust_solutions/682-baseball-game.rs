impl Solution {
    pub fn cal_points(ops: Vec<String>) -> i32 {
        let mut scores: Vec<i32> = Vec::new();

        for op in ops {
            match op.as_str() {
                "+" => {
                    let len = scores.len();
                    if len >= 2 {
                        let sum = scores[len - 1] + scores[len - 2];
                        scores.push(sum);
                    }
                }
                "D" => {
                    if let Some(&last_score) = scores.last() {
                        scores.push(last_score * 2);
                    }
                }
                "C" => {
                    scores.pop();
                }
                _ => {
                    if let Ok(score) = op.parse::<i32>() {
                        scores.push(score);
                    }
                }
            }
        }

        scores.iter().sum()
    }
}