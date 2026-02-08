use std::collections::HashSet;

impl Solution {
    pub fn top_k_students(
        positive_feedback: Vec<String>,
        negative_feedback: Vec<String>,
        report: Vec<String>,
        student_id: Vec<i32>,
        k: i32,
    ) -> Vec<i32> {
        let pos_set: HashSet<String> = positive_feedback.into_iter().collect();
        let neg_set: HashSet<String> = negative_feedback.into_iter().collect();

        let mut student_scores: Vec<(i32, i32)> = Vec::new();

        for i in 0..report.len() {
            let mut current_score = 0;
            let student_report = &report[i];
            let id = student_id[i];

            for word in student_report.split_whitespace() {
                if pos_set.contains(word) {
                    current_score += 3;
                } else if neg_set.contains(word) {
                    current_score -= 1;
                }
            }
            student_scores.push((current_score, id));
        }

        student_scores.sort_unstable_by(|a, b| {
            if a.0 != b.0 {
                b.0.cmp(&a.0)
            } else {
                a.1.cmp(&b.1)
            }
        });

        student_scores
            .into_iter()
            .take(k as usize)
            .map(|(_, id)| id)
            .collect()
    }
}