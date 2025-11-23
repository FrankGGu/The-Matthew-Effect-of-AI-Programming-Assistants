impl Solution {
    pub fn min_jump(jump: Vec<i32>) -> i32 {
        let n = jump.len();
        let mut visited = vec![false; n];
        let mut queue = std::collections::VecDeque::new();
        queue.push_back((0, 0));
        visited[0] = true;

        while let Some((pos, steps)) = queue.pop_front() {
            let next_pos = pos + jump[pos] as usize;
            if next_pos >= n {
                return steps + 1;
            }
            if !visited[next_pos] {
                visited[next_pos] = true;
                queue.push_back((next_pos, steps + 1));
            }
            for left in (0..pos).rev() {
                if !visited[left] && left + jump[left] as usize == pos {
                    visited[left] = true;
                    queue.push_back((left, steps + 1));
                } else if visited[left] {
                    break;
                }
            }
        }
        -1
    }
}