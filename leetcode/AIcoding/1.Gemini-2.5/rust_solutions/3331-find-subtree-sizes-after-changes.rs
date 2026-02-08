struct Solution;

impl Solution {
    pub fn find_subtree_sizes_after_changes(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut dfs_info = DfsInfo::new(n_usize, adj);
        dfs_info.dfs(0, n_usize); // Root at 0, n_usize as dummy parent

        let mut bit = FenwickTree::new(n_usize);
        let mut is_active = vec![true; n_usize]; // Initially all nodes are active

        // Initialize BIT with all nodes active (value 1 at their tin index)
        for i in 0..n_usize {
            bit.update(dfs_info.tin[i], 1);
        }

        let mut results = Vec::new();

        for query in queries {
            let type_ = query[0];
            let node_id = query[1] as usize;

            if type_ == 1 { // Toggle state of node_id
                if is_active[node_id] {
                    bit.update(dfs_info.tin[node_id], -1);
                    is_active[node_id] = false;
                } else {
                    bit.update(dfs_info.tin[node_id], 1);
                    is_active[node_id] = true;
                }
            } else { // Query subtree size for node_id
                let subtree_size = bit.query_range(dfs_info.tin[node_id], dfs_info.tout[node_id]);
                results.push(subtree_size);
            }
        }
        results
    }
}

struct DfsInfo {
    adj: Vec<Vec<usize>>,
    tin: Vec<usize>,
    tout: Vec<usize>,
    timer: usize,
}

impl DfsInfo {
    fn new(n: usize, adj: Vec<Vec<usize>>) -> Self {
        DfsInfo {
            adj,
            tin: vec![0; n],
            tout: vec![0; n],
            timer: 0,
        }
    }

    fn dfs(&mut self, u: usize, p: usize) {
        self.tin[u] = self.timer;
        self.timer += 1;

        for &v in &self.adj[u] {
            if v != p {
                self.dfs(v, u);
            }
        }
        self.tout[u] = self.timer - 1;
    }
}

struct FenwickTree {
    tree: Vec<i32>,
    size: usize,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        FenwickTree {
            tree: vec![0; size + 1],
            size,
        }
    }

    fn update(&mut self, mut i: usize, val: i32) {
        i += 1;
        while i <= self.size {
            self.tree[i] += val;
            i += i & (!i + 1);
        }
    }

    fn query(&self, mut i: usize) -> i32 {
        i += 1;
        let mut sum = 0;
        while i > 0 {
            sum += self.tree[i];
            i -= i & (!i + 1);
        }
        sum
    }

    fn query_range(&self, l: usize, r: usize) -> i32 {
        if l > r {
            return 0;
        }
        self.query(r) - self.query(l.saturating_sub(1))
    }
}