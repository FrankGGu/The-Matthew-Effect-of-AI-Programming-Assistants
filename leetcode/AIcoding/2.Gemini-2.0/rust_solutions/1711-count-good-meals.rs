use std::collections::HashMap;

impl Solution {
    pub fn count_good_meals(meals: Vec<i32>) -> i32 {
        let mut count: HashMap<i32, i32> = HashMap::new();
        let mut res: i64 = 0;
        let mod_val: i64 = 1_000_000_007;

        for meal in meals {
            for i in 0..22 {
                let power_of_two: i32 = 1 << i;
                let complement = power_of_two - meal;
                if count.contains_key(&complement) {
                    res = (res + *count.get(&complement).unwrap() as i64) % mod_val;
                }
            }
            *count.entry(meal).or_insert(0) += 1;
        }

        res as i32
    }
}