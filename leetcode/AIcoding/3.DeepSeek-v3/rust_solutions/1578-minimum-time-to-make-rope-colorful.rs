impl Solution {
    pub fn min_cost(colors: String, needed_time: Vec<i32>) -> i32 {
        let colors = colors.into_bytes();
        let mut total_time = 0;
        let mut i = 0;
        let n = colors.len();

        while i < n {
            let current_color = colors[i];
            let mut max_time = needed_time[i];
            let mut sum_time = needed_time[i];
            let mut j = i + 1;

            while j < n && colors[j] == current_color {
                sum_time += needed_time[j];
                max_time = max_time.max(needed_time[j]);
                j += 1;
            }

            if j - i > 1 {
                total_time += sum_time - max_time;
            }

            i = j;
        }

        total_time
    }
}