impl Solution {
    pub fn sum_of_three(num: i64) -> Vec<i64> {
        if num % 3 == 0 {
            let x = num / 3;
            vec![x - 1, x, x + 1]
        } else {
            vec![]
        }
    }
}