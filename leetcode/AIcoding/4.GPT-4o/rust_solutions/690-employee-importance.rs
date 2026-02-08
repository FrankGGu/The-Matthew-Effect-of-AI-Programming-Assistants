#[derive(Debug)]
pub struct Employee {
    pub id: i32,
    pub importance: i32,
    pub subordinates: Vec<i32>,
}

pub fn get_importance(employees: Vec<Employee>, id: i32) -> i32 {
    let mut map = std::collections::HashMap::new();
    for employee in employees {
        map.insert(employee.id, (employee.importance, employee.subordinates));
    }
    let mut total_importance = 0;
    let mut stack = vec![id];

    while let Some(emp_id) = stack.pop() {
        if let Some(&(importance, ref subordinates)) = map.get(&emp_id) {
            total_importance += importance;
            stack.extend(subordinates);
        }
    }

    total_importance
}