use std::collections::VecDeque;

impl Solution {
    pub fn get_coprimes(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut adj = vec![vec![]; n];
        for edge in &edges {
            adj[edge[0] as usize].push(edge[1] as usize);
            adj[edge[1] as usize].push(edge[0] as usize);
        }

        let mut ans = vec![-1; n];
        let mut stack: Vec<(usize, usize, Vec<Option<(usize, i32)>>)> = vec![(0, 0, vec![None; 51])];
        let mut visited = vec![false; n];

        while let Some((u, depth, mut path)) = stack.pop() {
            visited[u] = true;
            let num = nums[u] as usize;

            let mut best = -1;
            let mut best_depth = -1;

            for i in 1..=50 {
                if Self::gcd(num as i32, i as i32) == 1 {
                    if let Some((node, d)) = path[i] {
                        if d > best_depth as usize {
                            best_depth = d as i32;
                            best = node as i32;
                        }
                    }
                }
            }

            ans[u] = best;

            let prev = path[num];
            path[num] = Some((u, depth));

            for &v in &adj[u] {
                if !visited[v] {
                    stack.push((v, depth + 1, path.clone()));
                }
            }

            if let Some(p) = prev {
                path[num] = Some(p);
            } else {
                path[num] = None;
            }
        }

        ans
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}