pub fn make_all_degrees_even(edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    use std::collections::HashMap;

    let mut degree_count = HashMap::new();

    for edge in &edges {
        *degree_count.entry(edge[0]).or_insert(0) += 1;
        *degree_count.entry(edge[1]).or_insert(0) += 1;
    }

    let mut odd_nodes: Vec<i32> = degree_count.iter()
        .filter(|&(_, &deg)| deg % 2 != 0)
        .map(|(&node, _)| node)
        .collect();

    let mut result = edges.clone();

    while odd_nodes.len() >= 2 {
        let u = odd_nodes.pop().unwrap();
        let v = odd_nodes.pop().unwrap();
        result.push(vec![u, v]);

        *degree_count.get_mut(&u).unwrap() += 1;
        *degree_count.get_mut(&v).unwrap() += 1;

        if degree_count[&u] % 2 != 0 {
            odd_nodes.push(u);
        }
        if degree_count[&v] % 2 != 0 {
            odd_nodes.push(v);
        }
    }

    result
}