use std::collections::HashSet;

impl Solution {
    pub fn reward_top_k_students(
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
            let current_report = &report[i];
            let current_student_id = student_id[i];
            let mut score = 0;

            for word in current_report.split_whitespace() {
                if pos_set.contains(word) {
                    score += 3;
                } else if neg_set.contains(word) {
                    score -= 1;
                }
            }
            // Store as (-score, student_id) to sort by score descending, then student_id ascending
            student_scores.push((-score, current_student_id));
        }

        student_scores.sort_unstable();

        student_scores
            .into_iter()
            .take(k as usize)
            .map(|(_, id)| id)
            .collect()
    }
}