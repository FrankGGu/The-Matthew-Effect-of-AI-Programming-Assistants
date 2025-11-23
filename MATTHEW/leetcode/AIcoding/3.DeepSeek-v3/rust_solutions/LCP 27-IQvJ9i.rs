use std::collections::HashMap;

struct BlackBox {
    right_map: HashMap<i32, i32>,
    left_map: HashMap<i32, i32>,
    n: i32,
    m: i32,
}

impl BlackBox {
    fn new(n: i32, m: i32) -> Self {
        BlackBox {
            right_map: HashMap::new(),
            left_map: HashMap::new(),
            n,
            m,
        }
    }

    fn open(&mut self, index: i32, direction: i32) -> i32 {
        if direction == 1 {
            if let Some(&next) = self.right_map.get(&index) {
                return next;
            }
        } else {
            if let Some(&next) = self.left_map.get(&index) {
                return next;
            }
        }

        let mut current = index;
        let mut dir = direction;
        let mut visited = HashMap::new();
        let mut path = Vec::new();

        loop {
            if visited.contains_key(&(current, dir)) {
                break;
            }
            visited.insert((current, dir), path.len() as i32);
            path.push((current, dir));

            let total = 2 * (self.n + self.m);
            let next_pos = if dir == 1 {
                let right = current;
                let left = (total - right) % total;
                left
            } else {
                let left = current;
                let right = (total - left) % total;
                right
            };

            let next_dir = if next_pos == 0 || next_pos == self.n || next_pos == self.n + self.m || next_pos == self.n + self.m + self.n {
                -dir
            } else {
                dir
            };

            current = next_pos;
            dir = next_dir;
        }

        let cycle_start = *visited.get(&(current, dir)).unwrap();
        for i in 0..path.len() {
            let (pos, d) = path[i];
            let next_pos = if i + 1 < path.len() {
                let (next_p, _) = path[i + 1];
                next_p
            } else {
                let (next_p, _) = path[cycle_start as usize];
                next_p
            };
            if d == 1 {
                self.right_map.insert(pos, next_pos);
            } else {
                self.left_map.insert(pos, next_pos);
            }
        }

        if direction == 1 {
            *self.right_map.get(&index).unwrap()
        } else {
            *self.left_map.get(&index).unwrap()
        }
    }
}