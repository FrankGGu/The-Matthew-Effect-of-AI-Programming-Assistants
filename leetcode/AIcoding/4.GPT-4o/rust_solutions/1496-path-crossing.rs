impl Solution {
    pub fn is_path_crossing(path: String) -> bool {
        let mut visited = std::collections::HashSet::new();
        let (mut x, mut y) = (0, 0);
        visited.insert((x, y));

        for dir in path.chars() {
            match dir {
                'N' => y += 1,
                'S' => y -= 1,
                'E' => x += 1,
                'W' => x -= 1,
                _ => {}
            }
            if !visited.insert((x, y)) {
                return true;
            }
        }
        false
    }
}