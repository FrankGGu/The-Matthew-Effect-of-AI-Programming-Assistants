impl Solution {
    pub fn closest_node(edges: Vec<i32>, node1: i32, node2: i32) -> i32 {
        let n = edges.len();
        let mut reachable = vec![false; n];
        let mut stack = Vec::new();

        fn dfs(edges: &Vec<i32>, node: i32, reachable: &mut Vec<bool>, stack: &mut Vec<i32>) {
            if node == -1 || reachable[node as usize] {
                return;
            }
            reachable[node as usize] = true;
            stack.push(node);
            dfs(edges, edges[node as usize], reachable, stack);
        }

        dfs(&edges, node1, &mut reachable, &mut stack);
        let mut closest = -1;
        let mut min_distance = n as i32 + 1;

        for i in 0..n {
            if reachable[i] {
                let mut distance = 0;
                let mut current = i as i32;
                while current != -1 && current != node2 {
                    current = edges[current as usize];
                    distance += 1;
                }
                if current == node2 && distance < min_distance {
                    min_distance = distance;
                    closest = i as i32;
                }
            }
        }
        closest
    }
}