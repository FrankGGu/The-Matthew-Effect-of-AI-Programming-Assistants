use std::collections::HashMap;

pub fn possible_bipartition(n: i32, dislikes: Vec<Vec<i32>>) -> bool {
    let mut graph = vec![vec![]; n as usize + 1];
    for dislike in dislikes {
        graph[dislike[0] as usize].push(dislike[1]);
        graph[dislike[1] as usize].push(dislike[0]);
    }

    let mut colors = vec![0; n as usize + 1];

    for i in 1..=n {
        if colors[i as usize] == 0 && !dfs(i, 1, &mut colors, &graph) {
            return false;
        }
    }

    true
}

fn dfs(node: i32, color: i32, colors: &mut Vec<i32>, graph: &Vec<Vec<i32>>) -> bool {
    if colors[node as usize] != 0 {
        return colors[node as usize] == color;
    }
    colors[node as usize] = color;
    for &neighbor in &graph[node as usize] {
        if !dfs(neighbor, -color, colors, graph) {
            return false;
        }
    }
    true
}