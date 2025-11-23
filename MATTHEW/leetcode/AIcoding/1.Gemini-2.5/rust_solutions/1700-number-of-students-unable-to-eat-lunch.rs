impl Solution {
    pub fn count_students(students: Vec<i32>, sandwiches: Vec<i32>) -> i32 {
        let mut count_0 = 0;
        let mut count_1 = 0;

        for &student_pref in &students {
            if student_pref == 0 {
                count_0 += 1;
            } else {
                count_1 += 1;
            }
        }

        for &sandwich_type in &sandwiches {
            if sandwich_type == 0 {
                if count_0 > 0 {
                    count_0 -= 1;
                } else {
                    break;
                }
            } else {
                if count_1 > 0 {
                    count_1 -= 1;
                } else {
                    break;
                }
            }
        }

        count_0 + count_1
    }
}