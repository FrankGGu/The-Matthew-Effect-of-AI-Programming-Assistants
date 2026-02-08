impl Solution {
    pub fn training_plan(mut trainers: Vec<i32>, mut applicants: Vec<i32>) -> f64 {
        trainers.sort();
        applicants.sort();

        let mut sum: i64 = 0;
        for i in 0..trainers.len() {
            sum += (trainers[i] - applicants[i]) as i64;
        }

        sum as f64 / trainers.len() as f64
    }
}