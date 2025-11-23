use std::collections::HashMap;

impl Solution {
    pub fn count_good_meals(deliciousness: Vec<i32>) -> i32 {
        let modulo = 1_000_000_007;
        let mut counts: HashMap<i32, i64> = HashMap::new();
        for &d in &deliciousness {
            *counts.entry(d).or_insert(0) += 1;
        }

        let mut total_good_meals: i64 = 0;

        let mut powers_of_two: Vec<i32> = Vec::new();
        for i in 0..=21 { 
            powers_of_two.push(1 << i);
        }

        for (&d1, &count1) in &counts {
            for &p in &powers_of_two {
                let d2 = p - d1;

                if d2 < d1 {
                    continue;
                }

                if let Some(&count2) = counts.get(&d2) {
                    if d1 == d2 {
                        total_good_meals = (total_good_meals + (count1 * (count1 - 1) / 2)) % modulo;
                    } else {
                        total_good_meals = (total_good_meals + (count1 * count2)) % modulo;
                    }
                }
            }
        }

        total_good_meals as i32
    }
}