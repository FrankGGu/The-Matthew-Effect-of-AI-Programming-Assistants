struct Solution {}

impl Solution {
    pub fn min_cost_climbing_stairs(cost: Vec<i32>) -> i32 {
        let mut a = 0;
        let mut b = 0;
        for i in cost.iter().rev() {
            let c = *i + a.min(b);
            a = b;
            b = c;
        }
        b
    }
}