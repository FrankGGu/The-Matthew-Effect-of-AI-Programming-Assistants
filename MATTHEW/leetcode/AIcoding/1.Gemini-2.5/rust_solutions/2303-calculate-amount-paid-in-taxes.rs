impl Solution {
    pub fn calculate_tax(brackets: Vec<Vec<i32>>, income: i32) -> f64 {
        let mut total_tax: f64 = 0.0;
        let mut previous_upper_bound: i32 = 0;

        for bracket in brackets {
            let current_upper_bound = bracket[0];
            let percentage = bracket[1];

            let income_in_this_bracket_range = current_upper_bound - previous_upper_bound;

            let amount_to_tax_in_this_bracket = (income - previous_upper_bound).min(income_in_this_bracket_range);

            if amount_to_tax_in_this_bracket > 0 {
                total_tax += (amount_to_tax_in_this_bracket as f64) * (percentage as f64) / 100.0;
            }

            previous_upper_bound = current_upper_bound;

            if income <= previous_upper_bound {
                break;
            }
        }

        total_tax
    }
}