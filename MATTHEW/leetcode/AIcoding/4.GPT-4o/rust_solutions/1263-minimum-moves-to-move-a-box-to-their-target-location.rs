use std::collections::VecDeque;

impl Solution {
    pub fn min_moves_to_move_box(box: Vec<i32>, target: Vec<i32>, obstacles: Vec<Vec<i32>>) -> i32 {
        let mut obstacles_set = std::collections::HashSet::new();
        for obstacle in obstacles {
            obstacles_set.insert((obstacle[0], obstacle[1]));
        }

        let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
        let (bx, by) = (box[0], box[1]);
        let (tx, ty) = (target[0], target[1]);
        let mut visited = std::collections::HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((bx, by, 0, 0)); // box_x, box_y, player_x, player_y
        visited.insert((bx, by, 0, 0));

        while let Some((bx, by, px, py)) = queue.pop_front() {
            if (bx, by) == (tx, ty) {
                return 0;
            }
            for (dx, dy) in &directions {
                let (nbx, nby) = (bx + dx, by + dy);
                let (npx, npy) = (bx - dx, by - dy);

                if obstacles_set.contains(&(nbx, nby)) || nbx < 0 || nby < 0 || visited.contains(&(nbx, nby, bx, by)) {
                    continue;
                }

                if (npx, npy) == (bx, by) || obstacles_set.contains(&(npx, npy)) {
                    continue;
                }

                visited.insert((nbx, nby, bx, by));
                queue.push_back((nbx, nby, bx, by));
            }
        }

        -1
    }
}