impl Solution {

use std::collections::{HashMap, BTreeSet};

impl Solution {
    pub fn high_access_employees(employees: Vec<Vec<String>>) -> Vec<String> {
        let mut access_map = HashMap::new();

        for emp in employees {
            let name = &emp[0];
            let time = &emp[1];
            let time_num = time.parse::<i32>().unwrap();

            access_map.entry(name).or_insert_with(BTreeSet::new).insert(time_num);
        }

        let mut result = Vec::new();

        for (name, times) in access_map {
            let times: Vec<_> = times.into_iter().collect();
            for i in 0..times.len() - 2 {
                if times[i + 2] - times[i] < 100 {
                    result.push(name.clone());
                    break;
                }
            }
        }

        result.sort();
        result
    }
}
}