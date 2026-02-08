impl Solution {
    pub fn breakfast_combination(staple: Vec<i32>, mut drinks: Vec<i32>, x: i32) -> i32 {
        drinks.sort_unstable();
        let mut count: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        for s_price in staple {
            if s_price >= x {
                continue;
            }
            let remaining_budget = x - s_price;

            let num_eligible_drinks = drinks.partition_point(|&d_price| d_price <= remaining_budget);

            count = (count + num_eligible_drinks as i64) % modulo;
        }

        count as i32
    }
}