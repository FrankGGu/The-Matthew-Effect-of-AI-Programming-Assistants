impl Solution {
    pub fn most_visited(n: i32, rounds: Vec<i32>) -> Vec<i32> {
        let start = rounds[0];
        let end = rounds[rounds.len() - 1];

        if start <= end {
            (start..=end).collect()
        } else {
            (1..=end).chain(start..=n).collect()
        }
    }
}