use std::collections::HashMap;

impl Solution {
    pub fn alert_names(key_name: Vec<String>, key_time: Vec<String>) -> Vec<String> {
        let mut map: HashMap<String, Vec<i32>> = HashMap::new();
        for i in 0..key_name.len() {
            let name = key_name[i].clone();
            let time_str = &key_time[i];
            let parts: Vec<&str> = time_str.split(':').collect();
            let hour: i32 = parts[0].parse().unwrap();
            let minute: i32 = parts[1].parse().unwrap();
            let time = hour * 60 + minute;
            map.entry(name).or_insert(Vec::new()).push(time);
        }

        let mut result: Vec<String> = Vec::new();
        for (name, mut times) in map.into_iter() {
            times.sort();
            for i in 0..times.len() - 2 {
                if times[i + 2] - times[i] <= 60 {
                    result.push(name.clone());
                    break;
                }
            }
        }

        result.sort();
        result.dedup();
        result
    }
}