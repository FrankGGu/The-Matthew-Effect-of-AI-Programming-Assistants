impl Solution {
    pub fn sum_of_three(num: i64) -> Vec<i64> {
        if num % 3 != 0 {
            return vec![];
        }
        let middle = num / 3;
        vec![middle - 1, middle, middle + 1]
    }
}