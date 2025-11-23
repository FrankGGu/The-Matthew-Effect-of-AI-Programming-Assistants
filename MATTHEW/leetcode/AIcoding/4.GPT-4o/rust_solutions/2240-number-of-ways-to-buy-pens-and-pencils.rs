impl Solution {
    pub fn ways_to_buy_pens_pencils(total: i32, cost1: i32, cost2: i32) -> i32 {
        let mut count = 0;
        for pens in 0..=total / cost1 {
            let remaining = total - pens * cost1;
            count += remaining / cost2 + 1;
        }
        count
    }
}