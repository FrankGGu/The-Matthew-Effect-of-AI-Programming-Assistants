impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_strength(grades: Vec<i32>, k: i32) -> i32 {
        let mut grades = grades;
        grades.sort_by(|a, b| b.cmp(a));
        let k = k as usize;
        let mut result = 0;
        for i in 0..k {
            if i % 2 == 0 {
                result += grades[i];
            } else {
                result -= grades[i];
            }
        }
        result
    }
}
}