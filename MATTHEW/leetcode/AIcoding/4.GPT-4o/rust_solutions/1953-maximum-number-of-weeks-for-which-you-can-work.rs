impl Solution {
    pub fn max_weeks(arr: Vec<i32>) -> i32 {
        let total_jobs: i32 = arr.iter().sum();
        let max_jobs: i32 = *arr.iter().max().unwrap();
        let total_weeks = total_jobs + (arr.len() as i32 - 1);

        if total_weeks < 2 * max_jobs {
            total_weeks
        } else {
            total_jobs - max_jobs
        }
    }
}