use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct Employee {
  pub id: i32,
  pub importance: i32,
  pub subordinates: Vec<i32>,
}

struct Solution;

impl Solution {
    pub fn get_importance(employees: Vec<Employee>, id: i32) -> i32 {
        let mut id_to_employee_map: HashMap<i32, &Employee> = HashMap::new();
        for employee in &employees {
            id_to_employee_map.insert(employee.id, employee);
        }

        let mut total_importance = 0;
        let mut stack: Vec<i32> = vec![id];

        while let Some(current_id) = stack.pop() {
            if let Some(employee) = id_to_employee_map.get(&current_id) {
                total_importance += employee.importance;
                for sub_id in &employee.subordinates {
                    stack.push(*sub_id);
                }
            }
        }

        total_importance
    }
}