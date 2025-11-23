struct Solution;

impl Solution {
    pub fn count_winning_sequences(time: Vec<i64>, distance: Vec<i64>) -> i64 {
        let mut total_ways: i64 = 1;

        for i in 0..time.len() {
            let t = time[i];
            let d = distance[i];

            let discriminant = (t * t - 4 * d) as f64;

            if discriminant <= 0.0 {
                total_ways *= 0;
                break;
            }

            let sqrt_discriminant = discriminant.sqrt();

            let lower_bound = ((t as f64) - sqrt_discriminant) / 2.0;
            let upper_bound = ((t as f64) + sqrt_discriminant) / 2.0;

            let mut h_min = lower_bound.floor() as i64;
            if h_min * (t - h_min) <= d {
                h_min += 1;
            }
            h_min = h_min.max(0);

            let mut h_max = upper_bound.ceil() as i64;
            if h_max * (t - h_max) <= d {
                h_max -= 1;
            }
            h_max = h_max.min(t);

            let ways_for_race = (h_max - h_min + 1).max(0);
            total_ways *= ways_for_race;
        }

        total_ways
    }
}