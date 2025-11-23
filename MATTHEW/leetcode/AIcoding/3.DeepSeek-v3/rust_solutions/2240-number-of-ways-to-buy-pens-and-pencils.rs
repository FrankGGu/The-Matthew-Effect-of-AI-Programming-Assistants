impl Solution {
    pub fn ways_to_buy_pens_pencils(total: i32, cost1: i32, cost2: i32) -> i64 {
        let mut ways = 0i64;
        let max_pens = total / cost1;
        for pens in 0..=max_pens {
            let remaining = total - pens * cost1;
            let max_pencils = remaining / cost2;
            ways += max_pencils as i64 + 1;
        }
        ways
    }
}