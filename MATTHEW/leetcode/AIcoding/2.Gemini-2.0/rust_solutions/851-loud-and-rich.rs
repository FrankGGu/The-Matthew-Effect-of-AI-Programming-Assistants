impl Solution {
    pub fn loud_and_rich(richer: Vec<Vec<i32>>, quiet: Vec<i32>) -> Vec<i32> {
        let n = quiet.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &richer {
            adj[edge[1] as usize].push(edge[0] as usize);
        }

        let mut ans: Vec<i32> = vec![-1; n];

        for i in 0..n {
            if ans[i] == -1 {
                dfs(i, &adj, &quiet, &mut ans);
            }
        }

        ans
    }
}

fn dfs(node: usize, adj: &Vec<Vec<usize>>, quiet: &Vec<i32>, ans: &mut Vec<i32>) -> i32 {
    if ans[node] != -1 {
        return ans[node];
    }

    ans[node] = node as i32;
    let mut min_quiet = quiet[node];

    for &neighbor in &adj[node] {
        let neighbor_ans = dfs(neighbor, adj, quiet, ans);
        if quiet[neighbor_ans as usize] < min_quiet {
            min_quiet = quiet[neighbor_ans as usize];
            ans[node] = neighbor_ans;
        }
    }

    ans[node]
}