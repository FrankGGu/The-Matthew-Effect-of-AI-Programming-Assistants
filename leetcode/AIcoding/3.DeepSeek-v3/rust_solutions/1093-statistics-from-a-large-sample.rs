impl Solution {
    pub fn sample_stats(count: Vec<i32>) -> Vec<f64> {
        let mut min = -1.0;
        let mut max = -1.0;
        let mut sum = 0.0;
        let mut mode = 0;
        let mut mode_count = 0;
        let mut total = 0;

        for (num, &cnt) in count.iter().enumerate() {
            if cnt > 0 {
                if min == -1.0 {
                    min = num as f64;
                }
                max = num as f64;
                if cnt > mode_count {
                    mode_count = cnt;
                    mode = num;
                }
                sum += num as f64 * cnt as f64;
                total += cnt;
            }
        }

        let mean = sum / total as f64;

        let mut median = 0.0;
        let mut cum_sum = 0;
        let mut found = false;
        let median_pos1 = (total + 1) / 2;
        let median_pos2 = (total + 2) / 2;

        for (num, &cnt) in count.iter().enumerate() {
            if cnt == 0 {
                continue;
            }
            cum_sum += cnt;
            if !found && cum_sum >= median_pos1 {
                median += num as f64;
                found = true;
            }
            if cum_sum >= median_pos2 {
                median += num as f64;
                break;
            }
        }
        median /= 2.0;

        vec![min, max, mean, median, mode as f64]
    }
}