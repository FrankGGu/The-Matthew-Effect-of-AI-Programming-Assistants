use std::collections::HashMap;

pub fn valid_arrangement(pairs: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut graph = HashMap::new();
    let mut indegree = HashMap::new();

    for pair in &pairs {
        graph.entry(pair[0]).or_insert(vec![]).push(pair[1]);
        *indegree.entry(pair[0]).or_insert(0) += 0;
        *indegree.entry(pair[1]).or_insert(0) += 1;
    }

    let mut start = 0;
    for (node, &deg) in &indegree {
        if deg == 0 {
            start = *node;
            break;
        }
    }

    let mut result = vec![];
    let mut stack = vec![start];

    while let Some(node) = stack.pop() {
        while let Some(&next) = graph.get_mut(&node).and_then(|v| v.last()) {
            graph.get_mut(&node).unwrap().pop();
            stack.push(next);
            node = next;
        }
        result.push(vec![node, stack.pop().unwrap()]);
    }

    result.reverse();
    result
}