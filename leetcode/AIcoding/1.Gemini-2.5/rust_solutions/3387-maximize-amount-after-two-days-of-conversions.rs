impl Solution {
    pub fn maximize_amount(initial_amount: Vec<i64>, conversion_rate: Vec<i64>, discount1: i64, discount2: i64) -> i64 {
        let n = initial_amount.len();
        let mut total_max_amount = 0;

        for i in 0..n {
            let a = initial_amount[i];
            let r = conversion_rate[i];

            let val_no_conversion = a;
            let val_day1_only = a * r - discount1;
            let val_day2_only = a * r - discount2;
            let val_day1_then_day2 = a * r * r - discount1 - discount2;

            total_max_amount += val_no_conversion
                                .max(val_day1_only)
                                .max(val_day2_only)
                                .max(val_day1_then_day2);
        }

        total_max_amount
    }
}