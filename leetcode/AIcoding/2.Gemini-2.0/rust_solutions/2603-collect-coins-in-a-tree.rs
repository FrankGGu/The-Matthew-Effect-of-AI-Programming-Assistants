impl Solution {
    pub fn collect_the_coins(coins: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = coins.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let mut degree: Vec<i32> = vec![0; n];

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut leaves: Vec<usize> = Vec::new();
        for i in 0..n {
            if degree[i] == 1 && coins[i] == 0 {
                leaves.push(i);
            }
        }

        for leaf in leaves {
            degree[leaf] = 0;
            for &neighbor in &adj[leaf] {
                degree[neighbor] -= 1;
            }
        }

        let mut leaves: Vec<usize> = Vec::new();
        for i in 0..n {
            if degree[i] == 1 {
                leaves.push(i);
            }
        }

        for leaf in leaves {
            degree[leaf] = 0;
            for &neighbor in &adj[leaf] {
                degree[neighbor] -= 1;
            }
        }

        let mut leaves: Vec<usize> = Vec::new();
        for i in 0..n {
            if degree[i] == 1 {
                leaves.push(i);
            }
        }

        for leaf in leaves {
            degree[leaf] = 0;
            for &neighbor in &adj[leaf] {
                degree[neighbor] -= 1;
            }
        }

        let mut count = 0;
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            if degree[u] > 0 && degree[v] > 0 {
                count += 1;
            }
        }

        count * 2
    }
}