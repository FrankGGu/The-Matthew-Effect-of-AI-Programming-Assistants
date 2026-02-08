impl Solution {
    pub fn component_value(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let total: i32 = nums.iter().sum();
        let max_num = *nums.iter().max().unwrap();
        let max_possible = total / max_num;

        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        for k in (1..=max_possible).rev() {
            if total % k != 0 {
                continue;
            }
            let target = total / k;
            let mut visited = vec![false; n];
            if Self::dfs(0, &adj, &nums, target, &mut visited) == 0 {
                return k - 1;
            }
        }
        0
    }

    fn dfs(u: usize, adj: &Vec<Vec<usize>>, nums: &Vec<i32>, target: i32, visited: &mut Vec<bool>) -> i32 {
        visited[u] = true;
        let mut sum = nums[u];
        for &v in &adj[u] {
            if !visited[v] {
                sum += Self::dfs(v, adj, nums, target, visited);
                if sum > target {
                    return i32::MAX;
                }
            }
        }
        if sum == target {
            0
        } else {
            sum
        }
    }
}