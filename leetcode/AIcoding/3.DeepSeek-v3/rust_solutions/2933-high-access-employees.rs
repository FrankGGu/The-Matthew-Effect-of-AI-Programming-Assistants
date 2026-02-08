use std::collections::HashMap;

impl Solution {
    pub fn find_high_access_employees(access_times: Vec<Vec<String>>) -> Vec<String> {
        let mut map: HashMap<String, Vec<i32>> = HashMap::new();

        for entry in access_times {
            let name = entry[0].clone();
            let time_str = &entry[1];
            let hours = time_str[..2].parse::<i32>().unwrap();
            let minutes = time_str[2..].parse::<i32>().unwrap();
            let total = hours * 60 + minutes;
            map.entry(name).or_insert(Vec::new()).push(total);
        }

        let mut result = Vec::new();

        for (name, times) in map {
            let mut sorted_times = times.clone();
            sorted_times.sort_unstable();
            let mut high_access = false;

            for i in 0..sorted_times.len() {
                if i + 2 >= sorted_times.len() {
                    break;
                }
                if sorted_times[i + 2] - sorted_times[i] < 60 {
                    high_access = true;
                    break;
                }
            }

            if high_access {
                result.push(name);
            }
        }

        result
    }
}