impl Solution {
    pub fn find_smallest_set_of_vertices(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let mut in_degree = vec![0; n as usize];

        for edge in edges {
            let to = edge[1] as usize;
            in_degree[to] += 1;
        }

        let mut result = Vec::new();
        for i in 0..n {
            if in_degree[i as usize] == 0 {
                result.push(i);
            }
        }

        result
    }
}