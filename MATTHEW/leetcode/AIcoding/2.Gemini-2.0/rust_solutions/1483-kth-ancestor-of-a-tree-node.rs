struct TreeAncestor {
    ancestors: Vec<Vec<i32>>,
    n: i32,
    log_n: i32,
}

impl TreeAncestor {
    fn new(n: i32, parent: Vec<i32>) -> Self {
        let log_n = (n as f64).log2().floor() as i32 + 1;
        let mut ancestors = vec![vec![-1; n as usize]; log_n as usize];

        for i in 0..n {
            ancestors[0][i as usize] = parent[i as usize];
        }

        for i in 1..log_n {
            for j in 0..n {
                if ancestors[(i - 1) as usize][j as usize] != -1 {
                    ancestors[i as usize][j as usize] = ancestors[(i - 1) as usize][ancestors[(i - 1) as usize][j as usize] as usize];
                }
            }
        }

        TreeAncestor {
            ancestors,
            n,
            log_n,
        }
    }

    fn get_kth_ancestor(&self, node: i32, k: i32) -> i32 {
        let mut node = node;
        let mut k = k;

        for i in 0..self.log_n {
            if (k & (1 << i)) != 0 {
                node = self.ancestors[i as usize][node as usize];
                if node == -1 {
                    return -1;
                }
            }
        }

        node
    }
}