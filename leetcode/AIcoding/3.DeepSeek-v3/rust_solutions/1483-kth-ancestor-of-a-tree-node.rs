struct TreeAncestor {
    up: Vec<Vec<i32>>,
}

impl TreeAncestor {
    fn new(n: i32, parent: Vec<i32>) -> Self {
        let n = n as usize;
        let log = (32 - (n as u32).leading_zeros()) as usize;
        let mut up = vec![vec![-1; n]; log];
        up[0] = parent;
        for k in 1..log {
            for v in 0..n {
                if up[k-1][v] != -1 {
                    up[k][v] = up[k-1][up[k-1][v] as usize];
                }
            }
        }
        TreeAncestor { up }
    }

    fn get_kth_ancestor(&self, node: i32, k: i32) -> i32 {
        let mut node = node as usize;
        let mut k = k;
        for i in 0..32 {
            if k & (1 << i) != 0 {
                if node >= self.up.len() || self.up[i][node] == -1 {
                    return -1;
                }
                node = self.up[i][node] as usize;
            }
        }
        node as i32
    }
}