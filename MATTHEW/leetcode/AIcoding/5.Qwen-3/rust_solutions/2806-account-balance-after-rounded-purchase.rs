struct Solution;

impl Solution {
    pub fn account_balance(bill: i32) -> i32 {
        let rounded = (bill + 5) / 10 * 10;
        rounded - bill
    }
}