impl Solution {
    pub fn minimum_time(n: i32, rooms: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n + 1];
        for room in rooms {
            let u = room[0] as usize;
            let v = room[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n + 1];
        let mut max_time = 0;
        let mut stack = vec![(1, 0)];
        visited[1] = true;

        while let Some((u, time)) = stack.pop() {
            max_time = max_time.max(time);
            for &v in &graph[u] {
                if !visited[v] {
                    visited[v] = true;
                    stack.push((v, time + 1));
                }
            }
        }

        max_time
    }
}