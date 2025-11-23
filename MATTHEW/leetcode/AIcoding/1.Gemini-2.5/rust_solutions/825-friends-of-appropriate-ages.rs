impl Solution {
    pub fn num_friend_requests(ages: Vec<i32>) -> i32 {
        let mut counts = vec![0; 121]; // ages are 1 to 120. Index 0 is unused.
        for &age in ages.iter() {
            counts[age as usize] += 1;
        }

        let mut total_requests = 0;

        // Iterate through all possible ages for person A
        for age_a in 1..=120 {
            if counts[age_a as usize] == 0 {
                continue; // No one has this age, so A cannot be this age
            }

            // Conditions for A to friend B:
            // 1. age[B] > 0.5 * age[A] + 7
            // 2. age[B] <= age[A]
            // (The third condition "!(age[B] > 100 && age[A] < 100)" is always true if the first two are met,
            // given ages are between 1 and 120.)

            // Calculate the minimum age for B based on condition 1
            let min_b_age = (0.5 * age_a as f64 + 7.0).floor() as i32 + 1;

            // Iterate through all possible ages for person B
            // B's age must satisfy age[B] <= age[A] (condition 2)
            // and age[B] >= min_b_age (derived from condition 1)
            for age_b in min_b_age..=age_a {
                if age_b < 1 || age_b > 120 {
                    continue; // Age B is out of valid range, though this check is mostly redundant given min_b_age and age_a bounds
                }
                if counts[age_b as usize] == 0 {
                    continue; // No one has this age, so B cannot be this age
                }

                if age_a == age_b {
                    // If A and B have the same age, each person of this age will friend
                    // (counts[age_a] - 1) other people of the same age.
                    total_requests += counts[age_a as usize] * (counts[age_a as usize] - 1);
                } else {
                    // If A and B have different ages, each person of age_a will friend
                    // each person of age_b.
                    total_requests += counts[age_a as usize] * counts[age_b as usize];
                }
            }
        }

        total_requests
    }
}