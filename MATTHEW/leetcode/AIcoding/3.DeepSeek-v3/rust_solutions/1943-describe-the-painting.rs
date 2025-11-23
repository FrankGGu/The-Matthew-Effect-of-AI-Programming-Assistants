impl Solution {
    pub fn split_painting(segments: Vec<Vec<i32>>) -> Vec<Vec<i64>> {
        let mut events = Vec::new();
        for seg in segments {
            let (start, end, color) = (seg[0], seg[1], seg[2] as i64);
            events.push((start, color));
            events.push((end, -color));
        }
        events.sort_unstable();

        let mut res = Vec::new();
        let mut prev = 0;
        let mut current = 0;
        for &(pos, delta) in events.iter() {
            if pos != prev && current != 0 {
                res.push(vec![prev as i64, pos as i64, current]);
            }
            current += delta;
            prev = pos;
        }

        res
    }
}