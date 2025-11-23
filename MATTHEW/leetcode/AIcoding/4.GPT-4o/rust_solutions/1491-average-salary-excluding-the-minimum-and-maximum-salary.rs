impl Solution {
    pub fn average(salary: Vec<i32>) -> f64 {
        let min_salary = *salary.iter().min().unwrap();
        let max_salary = *salary.iter().max().unwrap();
        let sum: i32 = salary.iter().sum();
        let count = salary.len() as f64;
        (sum as f64 - min_salary as f64 - max_salary as f64) / (count - 2.0)
    }
}