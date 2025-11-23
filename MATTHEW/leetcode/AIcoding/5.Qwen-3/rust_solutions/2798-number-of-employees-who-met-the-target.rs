struct Solution;

impl Solution {
    pub fn numberOfEmployeesWhoMetTarget(employees: Vec<i32>, target: i32) -> i32 {
        employees.into_iter().filter(|&e| e >= target).count() as i32
    }
}