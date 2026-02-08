impl Solution {
    pub fn has_conflict(event1: Vec<String>, event2: Vec<String>) -> bool {
        fn parse_time_to_minutes(time_str: &str) -> i32 {
            let parts: Vec<&str> = time_str.split(':').collect();
            let hours: i32 = parts[0].parse().unwrap();
            let minutes: i32 = parts[1].parse().unwrap();
            hours * 60 + minutes
        }

        let start1 = parse_time_to_minutes(&event1[0]);
        let end1 = parse_time_to_minutes(&event1[1]);
        let start2 = parse_time_to_minutes(&event2[0]);
        let end2 = parse_time_to_minutes(&event2[1]);

        std::cmp::max(start1, start2) <= std::cmp::min(end1, end2)
    }
}