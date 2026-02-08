use std::collections::HashMap;

impl Solution {
    pub fn high_access_employees(access_times: Vec<Vec<String>>) -> Vec<String> {
        let mut employee_accesses: HashMap<String, Vec<i32>> = HashMap::new();

        for access in access_times {
            let employee_name = access[0].clone();
            let time_str = &access[1];

            let parts: Vec<&str> = time_str.split(':').collect();
            let hours: i32 = parts[0].parse().unwrap();
            let minutes: i32 = parts[1].parse().unwrap();
            let total_minutes = hours * 60 + minutes;

            employee_accesses.entry(employee_name)
                .or_insert_with(Vec::new)
                .push(total_minutes);
        }

        let mut high_access_employees_list: Vec<String> = Vec::new();

        for (employee_name, mut times) in employee_accesses {
            if times.len() < 3 {
                continue;
            }

            times.sort_unstable();

            let mut i = 0;
            let mut j = 2;

            while j < times.len() {
                if times[j] - times[i] <= 59 {
                    high_access_employees_list.push(employee_name.clone());
                    break;
                }

                i += 1;
                j += 1;
            }
        }

        high_access_employees_list
    }
}