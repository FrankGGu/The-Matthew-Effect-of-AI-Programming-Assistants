use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn top_students(positive_feedback: Vec<String>, negative_feedback: Vec<String>, report: Vec<String>, student_id: Vec<i32>, k: i32) -> Vec<i32> {
        let positive: HashSet<_> = positive_feedback.into_iter().collect();
        let negative: HashSet<_> = negative_feedback.into_iter().collect();

        let mut scores: Vec<_> = report.into_iter().zip(student_id.into_iter())
            .map(|(r, id)| {
                let words = r.split_whitespace();
                let score = words.fold(0, |acc, word| {
                    if positive.contains(word) {
                        acc + 3
                    } else if negative.contains(word) {
                        acc - 1
                    } else {
                        acc
                    }
                });
                (-score, id)
            })
            .collect();

        scores.sort_unstable();
        scores.into_iter().take(k as usize).map(|(_, id)| id).collect()
    }
}