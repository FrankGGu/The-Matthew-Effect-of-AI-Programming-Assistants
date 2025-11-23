struct DFSInfo {
    adj: Vec<Vec<usize>>,
    nums: Vec<i32>,
    subtree_xor: Vec<i32>,
    start_time: Vec<usize>,
    end_time: Vec<usize>,
    timer: usize,
}

impl DFSInfo {
    fn new(n: usize, nums: Vec<i32>, edges: Vec<Vec<i32>>) -> Self {
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }
        DFSInfo {
            adj,
            nums,
            subtree_xor: vec![0; n],
            start_time: vec![0; n],
            end_time: vec![0; n],
            timer: 0,
        }
    }

    fn dfs(&mut self, u: usize, p: usize) {
        self.timer += 1;
        self.start_time[u] = self.timer;
        self.subtree_xor[u] = self.nums[u];

        for &v in &self.adj[u] {
            if v == p {
                continue;
            }
            self.dfs(v, u);
            self.subtree_xor[u] ^= self.subtree_xor[v];
        }
        self.end_time[u] = self.timer;
    }

    fn is_ancestor(&self, u: usize, v: usize) -> bool {
        self.start_time[u] < self.start_time[v] && self.end_time[u] > self.end_time[v]
    }
}

impl Solution {
    pub fn minimum_score(n: i32, nums: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;
        let mut dfs_info = DFSInfo::new(n_usize, nums, edges);
        dfs_info.dfs(0, n_usize); 

        let total_xor_sum = dfs_info.subtree_xor[0];
        let mut min_score = i32::MAX;

        for i in 1..n_usize {
            for j in (i + 1)..n_usize {
                let xor1;
                let xor2;
                let xor3;

                if dfs_info.is_ancestor(i, j) {
                    xor1 = dfs_info.subtree_xor[j];
                    xor2 = dfs_info.subtree_xor[i] ^ dfs_info.subtree_xor[j];
                    xor3 = total_xor_sum ^ dfs_info.subtree_xor[i];
                }
                else if dfs_info.is_ancestor(j, i) {
                    xor1 = dfs_info.subtree_xor[i];
                    xor2 = dfs_info.subtree_xor[j] ^ dfs_info.subtree_xor[i];
                    xor3 = total_xor_sum ^ dfs_info.subtree_xor[j];
                }
                else {
                    xor1 = dfs_info.subtree_xor[i];
                    xor2 = dfs_info.subtree_xor[j];
                    xor3 = total_xor_sum ^ dfs_info.subtree_xor[i] ^ dfs_info.subtree_xor[j];
                }

                let current_scores = [xor1, xor2, xor3];
                let max_xor = *current_scores.iter().max().unwrap();
                let min_xor = *current_scores.iter().min().unwrap();
                min_score = min_score.min(max_xor - min_xor);
            }
        }

        min_score
    }
}