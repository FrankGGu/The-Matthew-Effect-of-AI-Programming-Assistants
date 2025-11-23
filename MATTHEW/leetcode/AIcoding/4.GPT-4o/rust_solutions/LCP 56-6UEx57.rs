impl Solution {
    pub fn can_transfer(n: i32, edges: Vec<Vec<i32>>, start: i32, end: i32) -> bool {
        use std::collections::{HashSet, HashMap, VecDeque};

        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for edge in edges {
            graph.entry(edge[0]).or_insert_with(Vec::new).push(edge[1]);
            graph.entry(edge[1]).or_insert_with(Vec::new).push(edge[0]);
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back(start);
        visited.insert(start);

        while let Some(node) = queue.pop_front() {
            if node == end {
                return true;
            }
            if let Some(neighbors) = graph.get(&node) {
                for &neighbor in neighbors {
                    if !visited.contains(&neighbor) {
                        visited.insert(neighbor);
                        queue.push_back(neighbor);
                    }
                }
            }
        }
        false
    }
}