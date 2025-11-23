impl Solution {
    pub fn robot(command: String, obstacles: Vec<Vec<i32>>, x: i32, y: i32) -> bool {
        let mut path = Vec::new();
        let (mut cx, mut cy) = (0, 0);
        for c in command.chars() {
            match c {
                'U' => cy += 1,
                'R' => cx += 1,
                _ => (),
            }
            path.push((cx, cy));
        }

        let cycle = path.last().unwrap().clone();
        let k = std::cmp::min(x / cycle.0, y / cycle.1);
        if k * cycle.0 != x || k * cycle.1 != y {
            return false;
        }

        for &(ox, oy) in &obstacles {
            if ox > x || oy > y {
                continue;
            }
            let k = std::cmp::min(ox / cycle.0, oy / cycle.1);
            let (rx, ry) = (ox - k * cycle.0, oy - k * cycle.1);
            if path.contains(&(rx, ry)) {
                return false;
            }
        }

        true
    }
}