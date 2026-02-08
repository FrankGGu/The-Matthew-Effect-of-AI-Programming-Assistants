impl Solution {
    pub fn possible_bipartition(n: i32, dislikes: Vec<Vec<i32>>) -> bool {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n + 1];
        for dislike in &dislikes {
            let u = dislike[0] as usize;
            let v = dislike[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut colors: Vec<i32> = vec![0; n + 1];

        for i in 1..=n {
            if colors[i] == 0 {
                let mut queue: Vec<usize> = vec![i];
                colors[i] = 1;

                while !queue.is_empty() {
                    let u = queue.remove(0);

                    for &v in &adj[u] {
                        if colors[v] == 0 {
                            colors[v] = -colors[u];
                            queue.push(v);
                        } else if colors[v] == colors[u] {
                            return false;
                        }
                    }
                }
            }
        }

        true
    }
}