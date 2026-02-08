struct Solution;

impl Solution {
    pub fn minimum_fuel_cost(roads: Vec<Vec<i32>>, seats: i32) -> i64 {
        use std::collections::VecDeque;

        let n = roads.len() + 1;
        let mut graph = vec![vec![]; n];
        for road in roads {
            graph[road[0] as usize].push(road[1]);
            graph[road[1] as usize].push(road[0]);
        }

        let mut total_cost = 0;
        let mut visited = vec![false; n];

        fn dfs(node: usize, graph: &Vec<Vec<i32>>, seats: i32, visited: &mut Vec<bool>) -> i64 {
            visited[node] = true;
            let mut passengers = 0;

            for &neighbor in &graph[node] {
                if !visited[neighbor as usize] {
                    passengers += dfs(neighbor as usize, graph, seats, visited);
                }
            }

            passengers += 1;
            if node != 0 {
                return (passengers + seats - 1) / seats;
            }
            passengers
        }

        total_cost += dfs(0, &graph, seats, &mut visited);

        total_cost
    }
}