use std::collections::HashMap;

#[derive(Default)]
struct Employee {
    id: i32,
    importance: i32,
    subordinates: Vec<i32>,
}

impl Employee {
    fn new(id: i32, importance: i32, subordinates: Vec<i32>) -> Self {
        Self { id, importance, subordinates }
    }
}

pub fn get_importance(employees: Vec<Employee>, id: i32) -> i32 {
    let mut employee_map: HashMap<i32, &Employee> = HashMap::new();
    for emp in &employees {
        employee_map.insert(emp.id, emp);
    }

    fn dfs(emp: &Employee, employee_map: &HashMap<i32, &Employee>) -> i32 {
        let mut total_importance = emp.importance;
        for &sub_id in &emp.subordinates {
            if let Some(sub_emp) = employee_map.get(&sub_id) {
                total_importance += dfs(sub_emp, employee_map);
            }
        }
        total_importance
    }

    if let Some(emp) = employee_map.get(&id) {
        dfs(emp, &employee_map)
    } else {
        0
    }
}