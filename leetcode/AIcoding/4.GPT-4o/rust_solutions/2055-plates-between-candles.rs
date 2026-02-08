impl Solution {
    pub fn plates_between_candles(s: String, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = s.len();
        let mut left_candle = vec![0; n];
        let mut right_candle = vec![0; n];
        let mut prefix_sum = vec![0; n + 1];

        let mut candle_index = -1;
        for i in 0..n {
            if s.chars().nth(i).unwrap() == '|' {
                candle_index = i as i32;
            }
            left_candle[i] = candle_index;
        }

        candle_index = -1;
        for i in (0..n).rev() {
            if s.chars().nth(i).unwrap() == '|' {
                candle_index = i as i32;
            }
            right_candle[i] = candle_index;
        }

        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + if s.chars().nth(i).unwrap() == '*' { 1 } else { 0 };
        }

        let mut result = Vec::new();
        for query in queries {
            let left = query[0] as usize;
            let right = query[1] as usize;
            let left_candle_index = right_candle[left];
            let right_candle_index = left_candle[right];

            if left_candle_index >= right_candle_index {
                result.push(0);
            } else {
                result.push(prefix_sum[right_candle_index as usize + 1] - prefix_sum[left_candle_index as usize]);
            }
        }

        result
    }
}