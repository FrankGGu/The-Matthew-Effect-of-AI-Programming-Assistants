impl Solution {
    pub fn count_result_probability(events: Vec<Vec<i32>>, sample_size: i32) -> Vec<f64> {
        let n = events.len();
        let mut result = vec![0.0; n];

        for i in 0..n {
            let mut win = events[i][0] as f64 / 1000.0;
            let lose = 1.0 - win;
            let target = events[i][1];

            let mut success = 0;
            for mask in 0..(1 << n) {
                let mut total_win = 0;
                let mut prob = 1.0;

                for j in 0..n {
                    if (mask >> j) & 1 == 1 {
                        if j == i {
                            total_win += 1;
                            prob *= win;
                        } else {
                            total_win += (events[j][0] > 0) as i32;
                            prob *= (events[j][0] as f64) / 1000.0;
                        }
                    } else {
                        if j == i {
                            prob *= lose;
                        } else {
                            prob *= (1000.0 - events[j][0] as f64) / 1000.0;
                        }
                    }
                }
                if total_win >= target {
                    success += 1;
                    result[i] += prob;
                }
            }
        }
        result
    }
}