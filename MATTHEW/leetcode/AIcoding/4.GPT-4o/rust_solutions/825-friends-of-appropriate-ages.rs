impl Solution {
    pub fn num_friends_age(ages: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut age_count = vec![0; 121];

        for &age in &ages {
            age_count[age as usize] += 1;
        }

        for i in 1..=120 {
            for j in 1..=120 {
                if i != j && j >= i / 2 + 7 && j <= i {
                    count += age_count[i] * age_count[j];
                }
            }
        }

        count / 2
    }
}