impl Solution {
    pub fn eventual_safe_nodes(graph: Vec<Vec<i32>>) -> Vec<i32> {
        let n = graph.len();
        let mut color = vec![0; n];
        let mut res = Vec::new();

        for i in 0..n {
            if Self::is_safe(&graph, &mut color, i) {
                res.push(i as i32);
            }
        }
        res
    }

    fn is_safe(graph: &Vec<Vec<i32>>, color: &mut Vec<i32>, node: usize) -> bool {
        if color[node] > 0 {
            return color[node] == 2;
        }
        color[node] = 1;
        for &neighbor in &graph[node] {
            let neighbor = neighbor as usize;
            if !Self::is_safe(graph, color, neighbor) {
                return false;
            }
        }
        color[node] = 2;
        true
    }
}