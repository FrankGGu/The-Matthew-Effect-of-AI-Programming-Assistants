impl Solution {
    pub fn num_friend_requests(ages: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut age_counts = vec![0; 121];
        for &age in &ages {
            age_counts[age as usize] += 1;
        }

        for a in 1..=120 {
            for b in 1..=120 {
                if a as f64 * 0.5 + 7.0 >= b as f64 {
                    continue;
                }
                if a < b {
                    continue;
                }
                if a < 100 && b > 100 {
                    continue;
                }
                if b > a {
                    continue;
                }

                if a == b {
                    count += age_counts[a as usize] * (age_counts[a as usize] - 1);
                } else {
                    count += age_counts[a as usize] * age_counts[b as usize];
                }
            }
        }

        count
    }
}