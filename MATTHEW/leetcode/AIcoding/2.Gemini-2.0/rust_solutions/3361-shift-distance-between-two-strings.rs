impl Solution {
    pub fn shift_distance(s: String, t: String) -> i32 {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let n = s_bytes.len();
        let mut min_dist = i32::MAX;

        for shift in 0..n {
            let mut dist = 0;
            for i in 0..n {
                let shifted_index = (i + shift) % n;
                let diff = (s_bytes[i] as i32 - t_bytes[shifted_index] as i32).abs();
                dist += diff;
            }
            min_dist = min_dist.min(dist);
        }

        min_dist
    }
}