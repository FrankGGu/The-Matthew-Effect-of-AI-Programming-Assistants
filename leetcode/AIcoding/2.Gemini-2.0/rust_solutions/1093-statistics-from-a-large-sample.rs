impl Solution {
    pub fn sample_stats(count: Vec<i32>) -> Vec<f64> {
        let mut min = -1;
        let mut max = -1;
        let mut sum = 0.0;
        let mut total = 0;
        let n = count.len();

        for i in 0..n {
            if count[i] > 0 {
                if min == -1 {
                    min = i as i32;
                }
                max = i as i32;
                sum += (i as f64) * (count[i] as f64);
                total += count[i];
            }
        }

        let mean = sum / (total as f64);

        let mut median = 0.0;
        let mut current_count = 0;
        let mut first = -1;
        let mut second = -1;

        for i in 0..n {
            current_count += count[i];
            if first == -1 && current_count >= (total + 1) / 2 {
                first = i as i32;
            }
            if second == -1 && current_count >= (total + 2) / 2 {
                second = i as i32;
            }
        }

        if total % 2 == 0 {
            median = ((first as f64) + (second as f64)) / 2.0;
        } else {
            median = first as f64;
        }

        let mut mode = 0;
        let mut max_count = 0;
        for i in 0..n {
            if count[i] > max_count {
                max_count = count[i];
                mode = i as i32;
            }
        }

        vec![min as f64, max as f64, mean, median, mode as f64]
    }
}