impl Solution {
    pub fn read_binary_watch(turned_on: i32) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();

        for h in 0..12 {
            for m in 0..60 {
                let bits_h = h.count_ones();
                let bits_m = m.count_ones();

                if (bits_h + bits_m) as i32 == turned_on {
                    result.push(format!("{}:{:02}", h, m));
                }
            }
        }

        result
    }
}