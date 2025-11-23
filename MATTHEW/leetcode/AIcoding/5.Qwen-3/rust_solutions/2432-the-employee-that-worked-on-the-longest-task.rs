impl Solution {

use std::cmp::Ordering;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Employee {
    id: i32,
    experience: i32,
}

pub fn longest_task(employees: Vec<Employee>) -> i32 {
    let mut max_experience = 0;
    let mut result_id = 0;

    for emp in employees {
        match emp.experience.cmp(&max_experience) {
            Ordering::Greater => {
                max_experience = emp.experience;
                result_id = emp.id;
            }
            Ordering::Equal => {
                if emp.id < result_id {
                    result_id = emp.id;
                }
            }
            _ => {}
        }
    }

    result_id
}
}