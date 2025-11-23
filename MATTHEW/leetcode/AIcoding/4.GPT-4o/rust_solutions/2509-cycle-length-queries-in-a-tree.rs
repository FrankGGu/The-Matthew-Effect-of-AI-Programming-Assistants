struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn cycle_length_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
    let mut parent = vec![0; n as usize + 1];
    for i in 2..=n {
        parent[i as usize] = i / 2;
    }

    queries.into_iter().map(|query| {
        let (mut a, mut b) = (query[0], query[1]);
        let mut visited = std::collections::HashSet::new();

        while a > 0 || b > 0 {
            if a > 0 {
                if visited.contains(&a) {
                    return visited.len() as i32 - visited.get(&a).unwrap_or(&0) + 1;
                }
                visited.insert(a);
                a = parent[a as usize];
            }
            if b > 0 {
                if visited.contains(&b) {
                    return visited.len() as i32 - visited.get(&b).unwrap_or(&0) + 1;
                }
                visited.insert(b);
                b = parent[b as usize];
            }
        }

        0
    }).collect()
}