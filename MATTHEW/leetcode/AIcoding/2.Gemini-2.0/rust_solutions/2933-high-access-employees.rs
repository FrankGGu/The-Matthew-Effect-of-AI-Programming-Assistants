use std::collections::HashMap;

impl Solution {
    pub fn high_access_employees(access_times: Vec<Vec<String>>) -> Vec<String> {
        let mut employee_access_times: HashMap<String, Vec<i32>> = HashMap::new();

        for access_time in access_times {
            let employee_id = access_time[0].clone();
            let time_str = &access_time[1];
            let time = time_str.parse::<i32>().unwrap();
            employee_access_times.entry(employee_id).or_insert(Vec::new()).push(time);
        }

        let mut result: Vec<String> = Vec::new();

        for (employee_id, mut times) in employee_access_times {
            times.sort();
            if times.len() >= 3 {
                for i in 0..times.len() - 2 {
                    if times[i + 2] - times[i] < 60 {
                        result.push(employee_id.clone());
                        break;
                    }
                }
            }
        }

        result
    }
}