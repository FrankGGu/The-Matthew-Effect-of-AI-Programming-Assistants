impl Solution {
    pub fn read_binary_watch(turned_on: i32) -> Vec<String> {
        let mut result = Vec::new();
        for h in 0..12 {
            for m in 0..60 {
                if h.count_ones() + m.count_ones() == turned_on {
                    result.push(format!("{:d}:{:02d}", h, m));
                }
            }
        }
        result
    }
}