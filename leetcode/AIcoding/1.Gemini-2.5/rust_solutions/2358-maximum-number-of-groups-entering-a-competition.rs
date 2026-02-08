impl Solution {
    pub fn max_groups_for_competition(grades: Vec<i32>) -> i32 {
        let mut n = grades.len();
        let mut k = 0;
        let mut students_for_next_group = 1;

        while n >= students_for_next_group {
            n -= students_for_next_group;
            k += 1;
            students_for_next_group += 1;
        }

        k as i32
    }
}