pub fn sample_stats(count: Vec<i32>) -> Vec f64> {
    let total_count: i32 = count.iter().sum();
    let mut min: f64 = -1.0;
    let mut max: f64 = -1.0;
    let mut sum: f64 = 0.0;
    let mut mean: f64 = 0.0;
    let mut median: f64 = 0.0;
    let mut cumulative_count = 0;
    let mut median_index = total_count / 2;
    let mut median_values = vec![];

    for (i, &c) in count.iter().enumerate() {
        if c > 0 {
            if min < 0.0 {
                min = i as f64;
            }
            max = i as f64;
            sum += i as f64 * c as f64;

            cumulative_count += c;

            if cumulative_count >= median_index && median_values.len() < 2 {
                median_values.push(i as f64);
            }
            if cumulative_count >= median_index + 1 && median_values.len() < 2 {
                median_values.push(i as f64);
            }
        }
    }

    mean = sum / total_count as f64;

    if median_values.len() == 1 {
        median = median_values[0];
    } else if median_values.len() == 2 {
        median = (median_values[0] + median_values[1]) / 2.0;
    }

    vec![min, max, mean, median]
}