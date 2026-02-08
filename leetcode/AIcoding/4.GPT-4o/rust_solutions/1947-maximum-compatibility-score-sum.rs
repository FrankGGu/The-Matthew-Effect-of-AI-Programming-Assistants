impl Solution {
    pub fn max_compatibility_sum(students: Vec<Vec<i32>>, mentors: Vec<Vec<i32>>) -> i32 {
        let n = students.len();
        let mut compatibility = vec![vec![0; n]; n];

        for i in 0..n {
            for j in 0..n {
                compatibility[i][j] = students[i].iter().zip(&mentors[j]).map(|(s, m)| s + m).sum();
            }
        }

        fn backtrack(students: &Vec<Vec<i32>>, mentors: &Vec<Vec<i32>>, compatibility: &Vec<Vec<i32>>, used: &mut Vec<bool>, index: usize, current_score: i32) -> i32 {
            if index == students.len() {
                return current_score;
            }
            let mut max_score = 0;
            for i in 0..mentors.len() {
                if !used[i] {
                    used[i] = true;
                    max_score = max_score.max(backtrack(students, mentors, compatibility, used, index + 1, current_score + compatibility[index][i]));
                    used[i] = false;
                }
            }
            max_score
        }

        let mut used = vec![false; n];
        backtrack(&students, &mentors, &compatibility, &mut used, 0, 0)
    }
}