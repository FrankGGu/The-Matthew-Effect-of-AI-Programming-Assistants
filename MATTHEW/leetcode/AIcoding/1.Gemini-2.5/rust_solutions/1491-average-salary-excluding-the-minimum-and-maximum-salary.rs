impl Solution {
    pub fn average(salary: Vec<i32>) -> f64 {
        let min_salary = *salary.iter().min().unwrap() as f64;
        let max_salary = *salary.iter().max().unwrap() as f64;
        let total_sum: f64 = salary.iter().map(|&s| s as f64).sum();
        let count = salary.len() as f64;

        (total_sum - min_salary - max_salary) / (count - 2.0)
    }
}