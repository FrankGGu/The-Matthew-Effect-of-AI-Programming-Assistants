use std::collections::HashSet;

impl Solution {
    pub fn reward_top_k(
        positive_feedback: Vec<String>,
        negative_feedback: Vec<String>,
        report: Vec<Vec<i32>>,
        student_id: Vec<i32>,
        k: i32,
    ) -> Vec<i32> {
        let positive_set: HashSet<String> = positive_feedback.into_iter().collect();
        let negative_set: HashSet<String> = negative_feedback.into_iter().collect();

        let mut scores: Vec<(i32, i32)> = Vec::new();
        for i in 0..student_id.len() {
            let mut score = 0;
            for &word_id in &report[i] {
                let word = word_id.to_string();
                if positive_set.contains(&word) {
                    score += 3;
                } else if negative_set.contains(&word) {
                    score -= 1;
                }
            }
            scores.push((score, student_id[i]));
        }

        scores.sort_by(|a, b| {
            if a.0 != b.0 {
                b.0.cmp(&a.0)
            } else {
                a.1.cmp(&b.1)
            }
        });

        let mut result: Vec<i32> = Vec::new();
        for i in 0..k.min(scores.len() as i32) as usize {
            result.push(scores[i].1);
        }

        result
    }
}