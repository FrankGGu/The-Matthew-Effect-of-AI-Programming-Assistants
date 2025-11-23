impl Solution {
    pub fn calculate_tax(brackets: Vec<Vec<i32>>, income: i32) -> f64 {
        let mut tax = 0.0;
        let mut previous_limit = 0;

        for bracket in brackets {
            let limit = bracket[0];
            let rate = bracket[1];

            if income > limit {
                tax += (limit - previous_limit) * rate as f64 / 100.0;
                previous_limit = limit;
            } else {
                tax += (income - previous_limit) * rate as f64 / 100.0;
                break;
            }
        }

        tax
    }
}