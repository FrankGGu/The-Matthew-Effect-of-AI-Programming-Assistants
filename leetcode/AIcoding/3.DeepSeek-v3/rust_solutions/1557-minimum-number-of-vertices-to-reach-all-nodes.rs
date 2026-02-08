impl Solution {
    pub fn find_smallest_set_of_vertices(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let mut in_degree = vec![0; n as usize];
        for edge in edges {
            in_degree[edge[1] as usize] += 1;
        }
        in_degree
            .into_iter()
            .enumerate()
            .filter(|&(_, degree)| degree == 0)
            .map(|(i, _)| i as i32)
            .collect()
    }
}