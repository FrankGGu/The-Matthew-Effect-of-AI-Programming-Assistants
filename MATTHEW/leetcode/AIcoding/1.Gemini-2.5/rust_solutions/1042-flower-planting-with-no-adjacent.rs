impl Solution {
    pub fn garden_no_adj(n: i32, paths: Vec<Vec<i32>>) -> Vec<i32> {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];

        for path in paths {
            let u = (path[0] - 1) as usize;
            let v = (path[1] - 1) as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut ans: Vec<i32> = vec![0; n_usize];

        for i in 0..n_usize {
            let mut used_flowers = [false; 5]; // Index 0 unused, 1-4 for flower types

            for &neighbor in &adj[i] {
                if ans[neighbor] != 0 {
                    used_flowers[ans[neighbor] as usize] = true;
                }
            }

            for flower_type in 1..=4 {
                if !used_flowers[flower_type] {
                    ans[i] = flower_type as i32;
                    break;
                }
            }
        }

        ans
    }
}