impl Solution {
    pub fn max_compatibility_sum(students: Vec<Vec<i32>>, mentors: Vec<Vec<i32>>) -> i32 {
        let m = students.len();
        let q = students[0].len();

        let mut compatibility_scores = vec![vec![0; m]; m];
        for i in 0..m {
            for j in 0..m {
                let mut score = 0;
                for k in 0..q {
                    if students[i][k] == mentors[j][k] {
                        score += 1;
                    }
                }
                compatibility_scores[i][j] = score;
            }
        }

        let mut max_sum = 0;

        fn solve_recursive(
            student_idx: usize,
            assigned_mentors_mask: u32,
            current_sum: i32,
            m: usize,
            compatibility_scores: &Vec<Vec<i32>>,
            max_sum: &mut i32,
        ) {
            if student_idx == m {
                *max_sum = (*max_sum).max(current_sum);
                return;
            }

            for mentor_idx in 0..m {
                if (assigned_mentors_mask >> mentor_idx) & 1 == 0 {
                    let new_mask = assigned_mentors_mask | (1 << mentor_idx);
                    let score_for_this_assignment = compatibility_scores[student_idx][mentor_idx];

                    solve_recursive(
                        student_idx + 1,
                        new_mask,
                        current_sum + score_for_this_assignment,
                        m,
                        compatibility_scores,
                        max_sum,
                    );
                }
            }
        }

        solve_recursive(0, 0, 0, m, &compatibility_scores, &mut max_sum);

        max_sum
    }
}