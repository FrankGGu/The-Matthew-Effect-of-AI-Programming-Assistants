impl Solution {
    pub fn count_ways(ranges: Vec<Vec<i32>>) -> i32 {
        let mut ranges = ranges;
        ranges.sort_by(|a, b| a[0].cmp(&b[0]));
        let mut merged: Vec<Vec<i32>> = Vec::new();
        for range in ranges {
            if merged.is_empty() || range[0] > merged.last().unwrap()[1] {
                merged.push(range);
            } else {
                let last = merged.last_mut().unwrap();
                last[1] = last[1].max(range[1]);
            }
        }
        let n = merged.len() as i64;
        let mut result: i64 = 1;
        let modulo: i64 = 1000000007;
        for _ in 0..n {
            result = (result * 2) % modulo;
        }
        result as i32
    }
}