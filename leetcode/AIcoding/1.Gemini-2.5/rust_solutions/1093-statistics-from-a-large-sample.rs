impl Solution {
    pub fn sample_statistics(count: Vec<i32>) -> Vec<f64> {
        let mut min_val: f64 = 0.0;
        let mut max_val: f64 = 0.0;
        let mut mean_val: f64 = 0.0;
        let mut median_val: f64 = 0.0;
        let mut mode_val: f64 = 0.0;

        let mut total_count: i64 = 0;
        let mut sum_values: i64 = 0;
        let mut max_freq: i32 = 0;

        let mut first_val_found = false;
        for i in 0..=255 {
            let freq = count[i as usize];
            if freq > 0 {
                if !first_val_found {
                    min_val = i as f64;
                    first_val_found = true;
                }
                max_val = i as f64;

                total_count += freq as i64;
                sum_values += (i as i64) * (freq as i64);

                if freq > max_freq {
                    max_freq = freq;
                    mode_val = i as f64;
                }
            }
        }

        if total_count == 0 {
            return vec![0.0, 0.0, 0.0, 0.0, 0.0];
        }

        mean_val = sum_values as f64 / total_count as f64;

        let mut current_rank: i64 = 0;
        let mut median_val1: f64 = 0.0;
        let mut median_val2: f64 = 0.0;
        let mut found_median1 = false;
        let mut found_median2 = false;

        let target_rank1 = (total_count + 1) / 2;
        let target_rank2 = (total_count + 2) / 2;

        for i in 0..=255 {
            let freq = count[i as usize];
            if freq > 0 {
                if !found_median1 && (current_rank + freq as i64) >= target_rank1 {
                    median_val1 = i as f64;
                    found_median1 = true;
                }
                if !found_median2 && (current_rank + freq as i64) >= target_rank2 {
                    median_val2 = i as f64;
                    found_median2 = true;
                }

                current_rank += freq as i64;

                if found_median1 && found_median2 {
                    break;
                }
            }
        }

        if total_count % 2 == 1 {
            median_val = median_val1;
        } else {
            median_val = (median_val1 + median_val2) / 2.0;
        }

        vec![min_val, max_val, mean_val, median_val, mode_val]
    }
}