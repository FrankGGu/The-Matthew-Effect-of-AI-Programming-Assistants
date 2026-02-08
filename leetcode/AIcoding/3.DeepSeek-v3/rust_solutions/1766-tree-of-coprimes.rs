use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn get_coprimes(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut coprimes = HashMap::new();
        for i in 1..=50 {
            for j in 1..=50 {
                if gcd(i, j) == 1 {
                    coprimes.entry(i).or_insert_with(Vec::new).push(j);
                }
            }
        }

        let mut res = vec![-1; n];
        let mut stack: Vec<(usize, Vec<(i32, usize)>)> = Vec::new();
        stack.push((0, Vec::new()));

        while let Some((u, path)) = stack.pop() {
            let num = nums[u];
            let mut max_depth = -1;
            let mut ancestor = -1;

            if let Some(coprime_list) = coprimes.get(&num) {
                for &coprime in coprime_list {
                    for &(val, node) in &path {
                        if val == coprime && node as i32 > max_depth {
                            max_depth = node as i32;
                            ancestor = node as i32;
                        }
                    }
                }
            }

            res[u] = ancestor;

            let mut new_path = path.clone();
            new_path.push((nums[u], u));

            for &v in &adj[u] {
                if res[v] == -1 {
                    stack.push((v, new_path.clone()));
                }
            }
        }

        res
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}