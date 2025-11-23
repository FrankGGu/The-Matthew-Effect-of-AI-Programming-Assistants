impl Solution {
    pub fn circular_game_losers(n: i32, k: i32) -> Vec<i32> {
        let mut visited = vec![false; n as usize];
        let mut current = 0;
        let mut step = 1;
        visited[current] = true;
        loop {
            current = (current + step * k) % n;
            if visited[current as usize] {
                break;
            }
            visited[current as usize] = true;
            step += 1;
        }
        visited
            .into_iter()
            .enumerate()
            .filter(|(_, v)| !*v)
            .map(|(i, _)| (i + 1) as i32)
            .collect()
    }
}