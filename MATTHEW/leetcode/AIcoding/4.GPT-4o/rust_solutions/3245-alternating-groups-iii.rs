impl Solution {
    pub fn alternating_groups(n: i32) -> Vec<i32> {
        let mut result = vec![];
        for i in 1..=n {
            if i % 2 == 1 {
                result.push(i);
            }
        }
        result
    }
}