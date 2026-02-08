impl Solution {
    pub fn max_compatibility_sum(students: Vec<Vec<i32>>, mentors: Vec<Vec<i32>>) -> i32 {
        let n = students.len();
        let m = mentors.len();
        let mut max_score = 0;

        fn calculate_score(student: &Vec<i32>, mentor: &Vec<i32>) -> i32 {
            let mut score = 0;
            for i in 0..student.len() {
                if student[i] == mentor[i] {
                    score += 1;
                }
            }
            score
        }

        fn permute(
            students: &Vec<Vec<i32>>,
            mentors: &Vec<Vec<i32>>,
            used: &mut Vec<bool>,
            current_score: i32,
            current_permutation: &mut Vec<usize>,
            max_score: &mut i32,
        ) {
            if current_permutation.len() == students.len() {
                *max_score = (*max_score).max(current_score);
                return;
            }

            for i in 0..mentors.len() {
                if !used[i] {
                    used[i] = true;
                    current_permutation.push(i);
                    let student_index = current_permutation.len() - 1;
                    let score = calculate_score(&students[student_index], &mentors[i]);
                    permute(
                        students,
                        mentors,
                        used,
                        current_score + score,
                        current_permutation,
                        max_score,
                    );
                    current_permutation.pop();
                    used[i] = false;
                }
            }
        }

        let mut used = vec![false; m];
        let mut current_permutation = Vec::new();
        permute(&students, &mentors, &mut used, 0, &mut current_permutation, &mut max_score);

        max_score
    }
}