impl Solution {
    pub fn ways_to_buy_pens_pencils(total: i32, cost1: i32, cost2: i32) -> i64 {
        let total_i64 = total as i64;
        let cost1_i64 = cost1 as i64;
        let cost2_i64 = cost2 as i64;

        let mut count: i64 = 0;

        for i in 0..=(total_i64 / cost1_i64) {
            let cost_of_pens = i * cost1_i64;
            let remaining_money = total_i64 - cost_of_pens;

            let ways_to_buy_pencils = (remaining_money / cost2_i64) + 1;
            count += ways_to_buy_pencils;
        }

        count
    }
}