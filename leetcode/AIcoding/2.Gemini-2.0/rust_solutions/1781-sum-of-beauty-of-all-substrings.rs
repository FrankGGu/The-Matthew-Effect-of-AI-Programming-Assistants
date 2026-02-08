impl Solution {
    pub fn beauty_sum(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s.len();
        let mut total_beauty = 0;

        for i in 0..n {
            for j in i..n {
                let mut counts = [0; 26];
                for k in i..=j {
                    counts[(s_bytes[k] - b'a') as usize] += 1;
                }

                let mut min_count = i32::MAX;
                let mut max_count = 0;

                for &count in &counts {
                    if count > 0 {
                        min_count = min_count.min(count);
                        max_count = max_count.max(count);
                    }
                }

                total_beauty += max_count - min_count;
            }
        }

        total_beauty
    }
}