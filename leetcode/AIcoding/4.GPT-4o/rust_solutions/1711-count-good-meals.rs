impl Solution {
    pub fn count_good_meals(deliciousness: Vec<i32>) -> i32 {
        use std::collections::HashMap;
        let mut count = 0;
        let mut freq = HashMap::new();
        let mod_val = 1_000_000_007;

        for &d in &deliciousness {
            for i in 0..=21 {
                let target = 1 << i;
                if let Some(&f) = freq.get(&(target - d)) {
                    count = (count + f) % mod_val;
                }
            }
            *freq.entry(d).or_insert(0) += 1;
        }
        count
    }
}