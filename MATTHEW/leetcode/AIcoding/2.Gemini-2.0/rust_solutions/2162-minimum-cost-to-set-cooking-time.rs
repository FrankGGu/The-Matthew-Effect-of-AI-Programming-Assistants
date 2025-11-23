impl Solution {
    pub fn min_cost_set_time(start_at: i32, move_cost: i32, push_cost: i32, target_seconds: i32) -> i32 {
        let mut min_cost = i32::MAX;

        for minutes in 0..100 {
            let seconds = target_seconds - minutes * 60;
            if seconds >= 0 && seconds < 100 {
                let mut digits1 = Vec::new();
                let mut m = minutes;
                digits1.push(m % 10);
                m /= 10;
                digits1.push(m % 10);

                let mut digits2 = Vec::new();
                let mut s = seconds;
                digits2.push(s % 10);
                s /= 10;
                digits2.push(s % 10);

                digits1.reverse();
                digits2.reverse();

                let mut final_digits = Vec::new();
                if digits1[0] != 0 || digits1[1] == 0 {
                    final_digits.push(digits1[0]);
                }
                final_digits.push(digits1[1]);
                final_digits.push(digits2[0]);
                final_digits.push(digits2[1]);

                let mut current = start_at;
                let mut cost = 0;

                for &digit in &final_digits {
                    if digit != current {
                        cost += move_cost;
                        current = digit;
                    }
                    cost += push_cost;
                }

                min_cost = min_cost.min(cost);
            }
        }

        min_cost
    }
}