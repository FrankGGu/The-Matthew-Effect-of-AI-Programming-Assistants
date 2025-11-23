impl Solution {
    pub fn number_of_employees_who_met_the_target(hours: Vec<i32>, target: i32) -> i32 {
        let mut count = 0;
        for &hour in &hours {
            if hour >= target {
                count += 1;
            }
        }
        count
    }
}