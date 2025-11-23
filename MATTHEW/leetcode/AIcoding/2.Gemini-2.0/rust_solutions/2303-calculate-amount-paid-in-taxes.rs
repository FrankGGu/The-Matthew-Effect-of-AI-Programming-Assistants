impl Solution {
    pub fn calculate_tax(brackets: Vec<Vec<i32>>, income: i32) -> f64 {
        let mut tax: f64 = 0.0;
        let mut prev: i32 = 0;
        for bracket in brackets {
            let upper: i32 = bracket[0];
            let percent: i32 = bracket[1];
            let taxable: i32 = std::cmp::min(income, upper) - prev;
            if taxable > 0 {
                tax += taxable as f64 * percent as f64 / 100.0;
            }
            prev = upper;
            if income <= upper {
                break;
            }
        }
        tax
    }
}