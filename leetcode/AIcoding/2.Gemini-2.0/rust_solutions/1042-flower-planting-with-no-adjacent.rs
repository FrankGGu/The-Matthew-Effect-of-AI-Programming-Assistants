impl Solution {
    pub fn garden_no_adj(n: i32, paths: Vec<Vec<i32>>) -> Vec<i32> {
        let mut adj: Vec<Vec<i32>> = vec![Vec::new(); n as usize];
        for path in paths {
            let u = path[0] - 1;
            let v = path[1] - 1;
            adj[u as usize].push(v);
            adj[v as usize].push(u);
        }

        let mut colors: Vec<i32> = vec![0; n as usize];

        for i in 0..n {
            let mut used_colors: [bool; 5] = [false; 5];
            for &neighbor in &adj[i as usize] {
                if colors[neighbor as usize] != 0 {
                    used_colors[colors[neighbor as usize] as usize] = true;
                }
            }

            for color in 1..=4 {
                if !used_colors[color as usize] {
                    colors[i as usize] = color;
                    break;
                }
            }
        }

        colors
    }
}