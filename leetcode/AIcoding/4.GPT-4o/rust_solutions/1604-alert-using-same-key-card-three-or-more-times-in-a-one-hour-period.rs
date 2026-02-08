use std::collections::HashMap;

pub fn alert_names(key_name: Vec<String>, key_time: Vec<String>) -> Vec<String> {
    let mut records: HashMap<String, Vec<i32>> = HashMap::new();

    for (name, time) in key_name.into_iter().zip(key_time) {
        let time_parts: Vec<i32> = time.split(':').map(|x| x.parse().unwrap()).collect();
        let minutes = time_parts[0] * 60 + time_parts[1];
        records.entry(name).or_insert_with(Vec::new).push(minutes);
    }

    let mut alerts: Vec<String> = Vec::new();

    for (name, times) in records {
        let mut times = times.clone();
        times.sort();

        for i in 0..times.len() {
            if i + 2 < times.len() && times[i + 2] - times[i] <= 60 {
                alerts.push(name.clone());
                break;
            }
        }
    }

    alerts.sort();
    alerts
}