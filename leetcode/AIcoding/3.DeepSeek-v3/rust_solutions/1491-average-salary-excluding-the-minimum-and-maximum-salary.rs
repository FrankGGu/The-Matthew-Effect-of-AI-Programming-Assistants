impl Solution {
    pub fn average(salary: Vec<i32>) -> f64 {
        let min_salary = *salary.iter().min().unwrap();
        let max_salary = *salary.iter().max().unwrap();
        let sum: i32 = salary.iter().sum();
        let filtered_sum = sum - min_salary - max_salary;
        filtered_sum as f64 / (salary.len() - 2) as f64
    }
}