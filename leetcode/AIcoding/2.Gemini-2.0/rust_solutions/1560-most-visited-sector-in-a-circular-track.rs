impl Solution {
    pub fn most_visited(n: i32, rounds: Vec<i32>) -> Vec<i32> {
        let mut start = rounds[0];
        let end = rounds.last().unwrap();

        let mut result = Vec::new();

        if start <= *end {
            for i in start..=*end {
                result.push(i);
            }
        } else {
            for i in 1..=*end {
                result.push(i);
            }
            for i in start..=n {
                result.push(i);
            }
        }

        result
    }
}