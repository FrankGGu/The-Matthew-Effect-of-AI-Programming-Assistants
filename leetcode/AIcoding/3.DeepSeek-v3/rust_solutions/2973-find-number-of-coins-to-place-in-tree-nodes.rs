use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

impl Solution {
    pub fn number_of_coins(tree: Vec<Vec<i32>>) -> Vec<i64> {
        let n = tree.len() + 1;
        let mut adj = vec![vec![]; n];
        for edge in tree {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut res = vec![0; n];
        let mut parent = vec![0; n];
        let mut children = vec![vec![]; n];
        let mut stack = vec![0];
        parent[0] = n;

        while let Some(u) = stack.pop() {
            for &v in &adj[u] {
                if v != parent[u] {
                    parent[v] = u;
                    children[u].push(v);
                    stack.push(v);
                }
            }
        }

        let mut size = vec![1; n];
        let mut sum = vec![0; n];
        let mut stack = vec![(0, false)];

        while let Some((u, processed)) = stack.pop() {
            if !processed {
                stack.push((u, true));
                for &v in &children[u] {
                    stack.push((v, false));
                }
            } else {
                for &v in &children[u] {
                    size[u] += size[v];
                    sum[u] += sum[v] + size[v] as i64;
                }
            }
        }

        res[0] = sum[0];
        let mut stack = vec![0];
        while let Some(u) = stack.pop() {
            for &v in &children[u] {
                res[v] = res[u] - size[v] as i64 + (n - size[v]) as i64;
                stack.push(v);
            }
        }

        res
    }
}