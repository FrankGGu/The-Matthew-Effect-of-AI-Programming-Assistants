impl Solution {
    pub fn edge_score(edges: Vec<i32>) -> i32 {
        let n = edges.len();
        let mut scores: Vec<i64> = vec![0; n];

        for i in 0..n {
            let dest_node = edges[i] as usize;
            scores[dest_node] += i as i64;
        }

        let mut max_score: i64 = 0;
        let mut result_node: i32 = 0;

        for u in 0..n {
            if scores[u] > max_score {
                max_score = scores[u];
                result_node = u as i32;
            }
        }

        result_node
    }
}