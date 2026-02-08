pub fn validate_binary_tree_nodes(n: i32, left_children: Vec<i32>, right_children: Vec<i32>) -> bool {
    let mut in_degree = vec![0; n as usize];
    let mut seen = vec![false; n as usize];

    for i in 0..n {
        if left_children[i as usize] != -1 {
            in_degree[left_children[i as usize] as usize] += 1;
            seen[left_children[i as usize] as usize] = true;
        }
        if right_children[i as usize] != -1 {
            in_degree[right_children[i as usize] as usize] += 1;
            seen[right_children[i as usize] as usize] = true;
        }
    }

    let root_count = in_degree.iter().filter(|&&x| x == 0).count();
    if root_count != 1 {
        return false;
    }

    let mut visited_count = 0;
    let mut stack = vec![in_degree.iter().position(|&x| x == 0).unwrap()];

    while let Some(node) = stack.pop() {
        if seen[node] {
            visited_count += 1;
            seen[node] = false;
            if left_children[node] != -1 {
                stack.push(left_children[node] as usize);
            }
            if right_children[node] != -1 {
                stack.push(right_children[node] as usize);
            }
        }
    }

    visited_count == n as usize
}