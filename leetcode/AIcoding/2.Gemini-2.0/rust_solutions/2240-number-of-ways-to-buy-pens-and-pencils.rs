impl Solution {
    pub fn ways_to_buy_pens_pencils(total: i32, cost1: i32, cost2: i32) -> i64 {
        let mut ans: i64 = 0;
        let mut num_pens: i64 = 0;
        while num_pens * cost1 as i64 <= total as i64 {
            let remaining = total as i64 - num_pens * cost1 as i64;
            ans += (remaining / cost2 as i64) + 1;
            num_pens += 1;
        }
        ans
    }
}