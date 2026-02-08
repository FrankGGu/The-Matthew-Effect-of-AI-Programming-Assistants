impl Solution {
    pub fn min_cost_set_time(start_at: i32, move_cost: i32, push_cost: i32, target_seconds: i32) -> i32 {
        let mut min_cost = i32::MAX;

        for m in 0..=99 {
            for s in 0..=99 {
                if m * 60 + s == target_seconds {
                    let mut cost = 0;
                    let mut current = start_at;
                    let digits = if m == 0 {
                        format!("{}", s)
                    } else {
                        format!("{:02}{:02}", m, s)
                    };

                    for ch in digits.chars() {
                        let digit = ch.to_digit(10).unwrap() as i32;
                        if digit != current {
                            cost += move_cost;
                            current = digit;
                        }
                        cost += push_cost;
                    }

                    if cost < min_cost {
                        min_cost = cost;
                    }
                }
            }
        }

        min_cost
    }
}