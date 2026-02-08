struct Solution;

impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    fn dfs(
        node: usize,
        parent: i32,
        depth: i32,
        adj: &[Vec<usize>],
        nums: &[i32],
        ans: &mut Vec<i32>,
        last_seen_depth: &mut Vec<i32>,
        last_seen_node_idx: &mut Vec<i32>,
    ) {
        let current_val = nums[node];
        let mut max_ancestor_depth = -1;
        let mut closest_ancestor_idx = -1;

        for val in 1..=50 {
            if last_seen_depth[val as usize] != -1 && Self::gcd(current_val, val) == 1 {
                if last_seen_depth[val as usize] > max_ancestor_depth {
                    max_ancestor_depth = last_seen_depth[val as usize];
                    closest_ancestor_idx = last_seen_node_idx[val as usize];
                }
            }
        }
        ans[node] = closest_ancestor_idx;

        let old_depth_for_current_val = last_seen_depth[current_val as usize];
        let old_node_idx_for_current_val = last_seen_node_idx[current_val as usize];

        last_seen_depth[current_val as usize] = depth;
        last_seen_node_idx[current_val as usize] = node as i32;

        for &neighbor in adj[node].iter() {
            if neighbor as i32 != parent {
                Self::dfs(
                    neighbor,
                    node as i32,
                    depth + 1,
                    adj,
                    nums,
                    ans,
                    last_seen_depth,
                    last_seen_node_idx,
                );
            }
        }

        last_seen_depth[current_val as usize] = old_depth_for_current_val;
        last_seen_node_idx[current_val as usize] = old_node_idx_for_current_val;
    }

    pub fn get_coprimes(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut ans: Vec<i32> = vec![-1; n];
        let mut last_seen_depth: Vec<i32> = vec![-1; 51];
        let mut last_seen_node_idx: Vec<i32> = vec![-1; 51];

        Self::dfs(
            0,
            -1,
            0,
            &adj,
            &nums,
            &mut ans,
            &mut last_seen_depth,
            &mut last_seen_node_idx,
        );

        ans
    }
}