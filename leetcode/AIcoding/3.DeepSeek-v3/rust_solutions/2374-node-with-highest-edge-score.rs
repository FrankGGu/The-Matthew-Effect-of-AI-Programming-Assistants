impl Solution {
    pub fn edge_score(edges: Vec<i32>) -> i32 {
        let n = edges.len();
        let mut scores = vec![0; n];

        for (i, &to) in edges.iter().enumerate() {
            scores[to as usize] += i as i64;
        }

        let max_score = *scores.iter().max().unwrap();
        scores.iter().position(|&x| x == max_score).unwrap() as i32
    }
}