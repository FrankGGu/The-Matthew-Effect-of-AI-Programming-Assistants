impl Solution {
    pub fn sort_the_students(score: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let k = k as usize;
        let mut indices: Vec<usize> = (0..score.len()).collect();
        indices.sort_by_key(|&i| -score[i][k]);
        let mut result: Vec<Vec<i32>> = Vec::new();
        for i in indices {
            result.push(score[i].clone());
        }
        result
    }
}