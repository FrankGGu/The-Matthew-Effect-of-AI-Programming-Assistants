use std::cmp::Ordering;

pub fn sort_the_students(score: Vec<Vec<i32>>, k: usize) -> Vec<Vec<i32>> {
    let mut sorted_scores = score.clone();
    sorted_scores.sort_unstable_by(|a, b| a[k].cmp(&b[k]).then_with(|| a.cmp(b)));
    sorted_scores
}