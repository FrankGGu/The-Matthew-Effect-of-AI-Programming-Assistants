impl Solution {
    pub fn read_binary_watch(turned_on: i32) -> Vec<String> {
        let mut result = Vec::new();
        for hour in 0..12 {
            for minute in 0..60 {
                if (hour.count_ones() + minute.count_ones()) as i32 == turned_on {
                    result.push(format!("{}:{:02}", hour, minute));
                }
            }
        }
        result
    }
}