impl Solution {
    pub fn calculate_tax(brackets: Vec<Vec<i32>>, income: i32) -> f64 {
        let mut tax = 0.0;
        let mut prev_upper = 0;

        for bracket in brackets {
            let upper = bracket[0];
            let percent = bracket[1];
            let taxable = (upper.min(income) - prev_upper).max(0);
            tax += taxable as f64 * percent as f64 / 100.0;
            prev_upper = upper;

            if income <= upper {
                break;
            }
        }

        tax
    }
}