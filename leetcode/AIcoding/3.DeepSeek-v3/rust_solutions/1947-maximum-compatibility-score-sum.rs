impl Solution {
    pub fn max_compatibility_sum(students: Vec<Vec<i32>>, mentors: Vec<Vec<i32>>) -> i32 {
        let m = students.len();
        let n = students[0].len();
        let mut score = vec![vec![0; m]; m];
        for i in 0..m {
            for j in 0..m {
                let mut s = 0;
                for k in 0..n {
                    if students[i][k] == mentors[j][k] {
                        s += 1;
                    }
                }
                score[i][j] = s;
            }
        }
        let mut max_score = 0;
        let mut used = vec![false; m];
        Self::backtrack(0, 0, &mut used, &score, &mut max_score);
        max_score
    }

    fn backtrack(pos: usize, current: i32, used: &mut Vec<bool>, score: &Vec<Vec<i32>>, max_score: &mut i32) {
        if pos == score.len() {
            *max_score = (*max_score).max(current);
            return;
        }
        for i in 0..score.len() {
            if !used[i] {
                used[i] = true;
                Self::backtrack(pos + 1, current + score[pos][i], used, score, max_score);
                used[i] = false;
            }
        }
    }
}