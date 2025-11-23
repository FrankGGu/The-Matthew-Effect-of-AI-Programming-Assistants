use std::collections::{VecDeque, HashMap};

pub fn largest_color_value(colors: String, edges: Vec<Vec<i32>>) -> i32 {
    let n = colors.len();
    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    let mut indegree = vec![0; n];

    for edge in edges {
        graph.entry(edge[0]).or_default().push(edge[1]);
        indegree[edge[1] as usize] += 1;
    }

    let mut queue = VecDeque::new();
    for i in 0..n {
        if indegree[i] == 0 {
            queue.push_back(i as i32);
        }
    }

    let mut color_count = vec![vec![0; 26]; n];
    let mut max_color_value = 0;

    while let Some(node) = queue.pop_front() {
        let color_index = colors.as_bytes()[node as usize] - b'a';
        color_count[node as usize][color_index as usize] += 1;

        for &next in graph.get(&node).unwrap_or(&Vec::new()) {
            for j in 0..26 {
                color_count[next as usize][j as usize] = color_count[next as usize][j as usize].max(color_count[node as usize][j as usize]);
            }
            indegree[next as usize] -= 1;
            if indegree[next as usize] == 0 {
                queue.push_back(next);
            }
        }
    }

    for count in color_count {
        max_color_value = max_color_value.max(*count.iter().max().unwrap());
    }

    if max_color_value == 0 {
        return -1;
    }

    max_color_value
}