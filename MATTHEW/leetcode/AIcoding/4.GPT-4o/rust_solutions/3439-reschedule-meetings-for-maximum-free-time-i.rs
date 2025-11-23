use std::collections::BTreeMap;

pub struct Solution;

impl Solution {
    pub fn max_free_time(meetings: Vec<Vec<i32>>) -> Vec<i32> {
        let mut time_slots: BTreeMap<i32, i32> = BTreeMap::new();
        for meeting in meetings {
            *time_slots.entry(meeting[0]).or_insert(0) += 1;
            *time_slots.entry(meeting[1]).or_insert(0) -= 1;
        }

        let mut free_times = vec![];
        let mut ongoing = 0;
        let mut last_time = -1;

        for (&time, &count) in time_slots.iter() {
            if ongoing == 0 && last_time != -1 {
                free_times.push(vec![last_time, time]);
            }
            ongoing += count;
            last_time = time;
        }

        free_times
    }
}