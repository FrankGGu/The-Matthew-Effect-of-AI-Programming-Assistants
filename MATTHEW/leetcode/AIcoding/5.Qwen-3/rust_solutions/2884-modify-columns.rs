impl Solution {

use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Employee {
    pub id: i32,
    pub name: String,
    pub sex: String,
    pub salary: i32,
}

pub fn modify_columns(mut employees: Vec<Employee>) -> Vec<Employee> {
    for emp in &mut employees {
        emp.name = format!("{}{}", emp.name, "aaa");
        emp.sex = match emp.sex.as_str() {
            "m" => "female".to_string(),
            "f" => "male".to_string(),
            _ => emp.sex.clone(),
        };
    }
    employees
}
}