struct Solution;

impl Solution {
    pub fn min_cost(colors: String, needed_time: Vec<i32>) -> i32 {
        let mut result = 0;
        let mut prev_char = ' ';
        let mut max_time = 0;
        let mut total_time = 0;

        for (i, c) in colors.chars().enumerate() {
            if c == prev_char {
                total_time += needed_time[i];
                max_time = max_time.max(needed_time[i]);
            } else {
                if prev_char != ' ' {
                    result += total_time - max_time;
                }
                prev_char = c;
                total_time = needed_time[i];
                max_time = needed_time[i];
            }
        }

        if prev_char != ' ' {
            result += total_time - max_time;
        }

        result
    }
}