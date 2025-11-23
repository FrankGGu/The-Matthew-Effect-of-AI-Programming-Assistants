use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct Employee {
    pub id: i32,
    pub importance: i32,
    pub subordinates: Vec<i32>,
}

impl Solution {
    pub fn get_importance(employees: Vec<Employee>, id: i32) -> i32 {
        let mut map = HashMap::new();
        for emp in employees {
            map.insert(emp.id, emp);
        }
        let mut total = 0;
        let mut stack = vec![id];
        while let Some(current_id) = stack.pop() {
            if let Some(emp) = map.get(&current_id) {
                total += emp.importance;
                for &sub_id in &emp.subordinates {
                    stack.push(sub_id);
                }
            }
        }
        total
    }
}