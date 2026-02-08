pub fn minimize_total_price(n: i32, edges: Vec<Vec<i32>>, price: Vec<i32>) -> i32 {
    use std::collections::{HashMap, HashSet};

    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    for edge in edges {
        graph.entry(edge[0]).or_insert_with(Vec::new).push(edge[1]);
        graph.entry(edge[1]).or_insert_with(Vec::new).push(edge[0]);
    }

    let mut dp = vec![0; n as usize];
    let mut visited = vec![false; n as usize];

    fn dfs(node: i32, graph: &HashMap<i32, Vec<i32>>, price: &Vec<i32>, dp: &mut Vec<i32>, visited: &mut Vec<bool>) -> i32 {
        visited[node as usize] = true;
        let mut total = 0;
        let mut child_cost = 0;

        for &neighbor in graph.get(&node).unwrap() {
            if !visited[neighbor as usize] {
                child_cost += dfs(neighbor, graph, price, dp, visited);
            }
        }

        total = price[node as usize] + child_cost;

        dp[node as usize] = total;
        total
    }

    let mut overall_min = 0;

    for i in 0..n {
        if !visited[i as usize] {
            let total_price = dfs(i, &graph, &price, &mut dp, &mut visited);
            overall_min += total_price;
        }
    }

    overall_min
}