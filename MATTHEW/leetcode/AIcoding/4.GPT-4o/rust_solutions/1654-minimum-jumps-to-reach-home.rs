impl Solution {
    pub fn minimum_jumps(forbidden: Vec<i32>, a: i32, b: i32, x: i32) -> i32 {
        let mut forbidden_set = std::collections::HashSet::new();
        for &pos in &forbidden {
            forbidden_set.insert(pos);
        }
        let mut queue = std::collections::VecDeque::new();
        let mut visited = std::collections::HashSet::new();
        queue.push_back((0, 0, false));
        visited.insert((0, false));

        while let Some((pos, steps, can_back)) = queue.pop_front() {
            if pos == x {
                return steps;
            }
            let forward = pos + a;
            if forward <= 6000 && !forbidden_set.contains(&forward) && !visited.contains(&(forward, false)) {
                visited.insert((forward, false));
                queue.push_back((forward, steps + 1, false));
            }
            if can_back {
                let backward = pos - b;
                if backward >= 0 && !forbidden_set.contains(&backward) && !visited.contains(&(backward, true)) {
                    visited.insert((backward, true));
                    queue.push_back((backward, steps + 1, true));
                }
            }
            if !can_back {
                queue.push_back((pos, steps + 1, true));
            }
        }
        -1
    }
}