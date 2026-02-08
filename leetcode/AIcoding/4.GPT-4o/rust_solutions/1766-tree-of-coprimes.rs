use std::collections::HashMap;

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn get_coprimes(root: Option<Box<TreeNode>>, nums: Vec<i32>) -> Vec<Vec<i32>> {
    let mut result = vec![];
    let mut coprime_map: HashMap<i32, Vec<i32>> = HashMap::new();
    let mut parent = vec![-1; nums.len()];
    let mut depth = vec![0; nums.len()];

    fn dfs(node: Option<&Box<TreeNode>>, depth_val: usize, parent_val: i32, nums: &Vec<i32>, coprime_map: &mut HashMap<i32, Vec<i32>>) {
        if let Some(n) = node {
            let index = n.val as usize;
            depth[index] = depth_val;
            parent[index] = parent_val;
            coprime_map.entry(nums[index]).or_default().push(n.val);
            dfs(n.left.as_deref(), depth_val + 1, n.val, nums, coprime_map);
            dfs(n.right.as_deref(), depth_val + 1, n.val, nums, coprime_map);
        }
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 { a } else { gcd(b, a % b) }
    }

    fn find_coprimes(node_val: i32, depth: &Vec<i32>, coprime_map: &HashMap<i32, Vec<i32>>, result: &mut Vec<Vec<i32>>) {
        let mut current = node_val;
        let mut temp = vec![];

        while current != -1 {
            if let Some(coprimes) = coprime_map.get(&current) {
                for &val in coprimes {
                    if gcd(val, node_val) == 1 {
                        temp.push(val);
                    }
                }
            }
            current = parent[current as usize];
        }

        result.push(temp);
    }

    if let Some(root_node) = root {
        dfs(Some(&root_node), 0, -1, &nums, &mut coprime_map);
        for i in 0..nums.len() {
            find_coprimes(i as i32, &depth, &coprime_map, &mut result);
        }
    }
    result
}