impl Solution {
    pub fn temperature_trend(temperatures: Vec<i32>, differences: Vec<i32>) -> i32 {
        let n = temperatures.len();
        if n <= 1 {
            return 0;
        }

        let mut trend = vec![0; n - 1];
        for i in 0..n - 1 {
            if temperatures[i + 1] > temperatures[i] {
                trend[i] = 1;
            } else if temperatures[i + 1] < temperatures[i] {
                trend[i] = -1;
            } else {
                trend[i] = 0;
            }
        }

        let mut diff_trend = vec![0; n - 1];
        for i in 0..n - 1 {
            if differences[i + 1] > differences[i] {
                diff_trend[i] = 1;
            } else if differences[i + 1] < differences[i] {
                diff_trend[i] = -1;
            } else {
                diff_trend[i] = 0;
            }
        }

        let mut max_len = 0;
        let mut curr_len = 0;
        for i in 0..n - 1 {
            if trend[i] == diff_trend[i] {
                curr_len += 1;
            } else {
                max_len = max_len.max(curr_len);
                curr_len = 0;
            }
        }
        max_len = max_len.max(curr_len);

        max_len as i32
    }
}