impl Solution {
    pub fn sort_the_students(mut score: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let k_usize = k as usize;
        score.sort_by(|a, b| b[k_usize].cmp(&a[k_usize]));
        score
    }
}