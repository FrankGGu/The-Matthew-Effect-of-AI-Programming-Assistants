impl Solution {
    pub fn garden_no_adj(n: i32, paths: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = vec![vec![]; n + 1];
        for path in paths {
            let u = path[0] as usize;
            let v = path[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut colors = vec![0; n + 1];
        for u in 1..=n {
            let mut used = vec![false; 5];
            for &v in &graph[u] {
                used[colors[v] as usize] = true;
            }
            for color in 1..=4 {
                if !used[color] {
                    colors[u] = color as i32;
                    break;
                }
            }
        }

        colors[1..=n].to_vec()
    }
}