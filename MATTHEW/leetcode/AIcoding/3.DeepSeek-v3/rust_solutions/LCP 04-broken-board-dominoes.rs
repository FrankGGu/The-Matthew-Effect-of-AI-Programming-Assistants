impl Solution {
    pub fn domino(n: i32, m: i32, broken: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let m = m as usize;
        let mut board = vec![vec![true; m]; n];
        for b in broken {
            let i = b[0] as usize;
            let j = b[1] as usize;
            board[i][j] = false;
        }

        let mut graph = vec![vec![]; n * m];
        let mut visited = vec![false; n * m];
        let mut matched = vec![-1; n * m];

        for i in 0..n {
            for j in 0..m {
                if !board[i][j] || (i + j) % 2 != 0 {
                    continue;
                }
                let u = i * m + j;
                if i > 0 && board[i - 1][j] {
                    let v = (i - 1) * m + j;
                    graph[u].push(v);
                }
                if i + 1 < n && board[i + 1][j] {
                    let v = (i + 1) * m + j;
                    graph[u].push(v);
                }
                if j > 0 && board[i][j - 1] {
                    let v = i * m + j - 1;
                    graph[u].push(v);
                }
                if j + 1 < m && board[i][j + 1] {
                    let v = i * m + j + 1;
                    graph[u].push(v);
                }
            }
        }

        fn bpm(u: usize, graph: &Vec<Vec<usize>>, visited: &mut Vec<bool>, matched: &mut Vec<i32>) -> bool {
            for &v in &graph[u] {
                if !visited[v] {
                    visited[v] = true;
                    if matched[v] == -1 || bpm(matched[v] as usize, graph, visited, matched) {
                        matched[v] = u as i32;
                        return true;
                    }
                }
            }
            false
        }

        let mut result = 0;
        for i in 0..n {
            for j in 0..m {
                if !board[i][j] || (i + j) % 2 != 0 {
                    continue;
                }
                let u = i * m + j;
                visited.fill(false);
                if bpm(u, &graph, &mut visited, &mut matched) {
                    result += 1;
                }
            }
        }
        result
    }
}