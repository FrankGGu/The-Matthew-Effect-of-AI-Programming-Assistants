impl Solution {
    pub fn plates_between_candles(s: String, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = s.len();
        let s_bytes = s.as_bytes();

        let mut prefix_plates = vec![0; n + 1];
        for i in 0..n {
            prefix_plates[i + 1] = prefix_plates[i] + if s_bytes[i] == b'*' { 1 } else { 0 };
        }

        let mut left_candle = vec![-1; n];
        let mut last_candle_idx = -1;
        for i in 0..n {
            if s_bytes[i] == b'|' {
                last_candle_idx = i as i32;
            }
            left_candle[i] = last_candle_idx;
        }

        let mut right_candle = vec![-1; n];
        last_candle_idx = -1;
        for i in (0..n).rev() {
            if s_bytes[i] == b'|' {
                last_candle_idx = i as i32;
            }
            right_candle[i] = last_candle_idx;
        }

        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let l_idx = query[0] as usize;
            let r_idx = query[1] as usize;

            let first_valid_candle = right_candle[l_idx];
            let last_valid_candle = left_candle[r_idx];

            if first_valid_candle == -1 || last_valid_candle == -1 || first_valid_candle >= last_valid_candle {
                results.push(0);
            } else {
                let count = prefix_plates[last_valid_candle as usize] - prefix_plates[(first_valid_candle + 1) as usize];
                results.push(count);
            }
        }

        results
    }
}