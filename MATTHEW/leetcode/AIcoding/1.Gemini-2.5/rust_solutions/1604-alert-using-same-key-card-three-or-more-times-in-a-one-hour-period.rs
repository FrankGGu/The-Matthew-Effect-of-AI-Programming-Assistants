use std::collections::HashMap;

impl Solution {
    pub fn alert_names(key_time: Vec<Vec<String>>) -> Vec<String> {
        let mut employee_times: HashMap<String, Vec<i32>> = HashMap::new();

        for entry in key_time {
            let name = entry[0].clone();
            let time_str = &entry[1];

            let parts: Vec<&str> = time_str.split(':').collect();
            let hour: i32 = parts[0].parse().unwrap();
            let minute: i32 = parts[1].parse().unwrap();
            let total_minutes = hour * 60 + minute;

            employee_times.entry(name).or_insert_with(Vec::new).push(total_minutes);
        }

        let mut alert_names: Vec<String> = Vec::new();

        for (name, mut times) in employee_times {
            if times.len() < 3 {
                continue;
            }

            times.sort_unstable();

            for i in 0..times.len() - 2 {
                if times[i + 2] - times[i] <= 60 {
                    alert_names.push(name.clone());
                    break;
                }
            }
        }

        alert_names.sort_unstable();
        alert_names
    }
}