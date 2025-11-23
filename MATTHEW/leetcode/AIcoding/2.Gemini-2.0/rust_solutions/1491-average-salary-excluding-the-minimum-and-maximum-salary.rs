impl Solution {
    pub fn average(salary: Vec<i32>) -> f64 {
        let mut min_salary = i32::MAX;
        let mut max_salary = i32::MIN;
        let mut sum = 0;

        for &s in &salary {
            sum += s;
            min_salary = min_salary.min(s);
            max_salary = max_salary.max(s);
        }

        (sum - min_salary - max_salary) as f64 / (salary.len() as i32 - 2) as f64
    }
}