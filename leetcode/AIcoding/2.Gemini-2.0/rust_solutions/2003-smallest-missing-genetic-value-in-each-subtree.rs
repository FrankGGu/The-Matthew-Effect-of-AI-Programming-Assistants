impl Solution {
    pub fn smallest_missing_genetic_value(parents: Vec<i32>, nums: Vec<i32>) -> Vec<i32> {
        let n = parents.len();
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        for i in 0..n {
            if parents[i] != -1 {
                adj[parents[i] as usize].push(i);
            }
        }

        let mut has_one = false;
        let mut one_idx = 0;
        for i in 0..n {
            if nums[i] == 1 {
                has_one = true;
                one_idx = i;
                break;
            }
        }

        if !has_one {
            return vec![1; n];
        }

        let mut visited = vec![false; n];
        let mut seen = vec![false; n + 1];
        let mut missing = 1;
        let mut ans = vec![1; n];
        let mut curr = one_idx;

        while curr >= 0 {
            Solution::dfs(curr, &adj, &nums, &mut visited, &mut seen);

            while seen[missing] {
                missing += 1;
            }

            ans[curr] = missing as i32;

            if parents[curr] == -1 {
                break;
            }

            curr = parents[curr] as usize;
        }

        ans
    }

    fn dfs(node: usize, adj: &Vec<Vec<usize>>, nums: &Vec<i32>, visited: &mut Vec<bool>, seen: &mut Vec<bool>) {
        if visited[node] {
            return;
        }

        visited[node] = true;
        seen[nums[node] as usize] = true;

        for &neighbor in &adj[node] {
            Solution::dfs(neighbor, adj, nums, visited, seen);
        }
    }
}