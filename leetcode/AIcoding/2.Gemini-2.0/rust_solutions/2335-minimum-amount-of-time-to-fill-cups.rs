impl Solution {
    pub fn fill_cups(amount: Vec<i32>) -> i32 {
        let mut amount = amount;
        amount.sort_unstable();
        let a = amount[0];
        let b = amount[1];
        let c = amount[2];

        if a + b <= c {
            return c;
        } else {
            return (a + b + c + 1) / 2;
        }
    }
}