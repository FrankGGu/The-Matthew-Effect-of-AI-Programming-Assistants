impl Solution {
    pub fn navigation(start: Vec<i32>, end: Vec<i32>, obstacles: Vec<Vec<i32>>) -> i32 {
        use std::collections::VecDeque;

        let mut obstacles_set = std::collections::HashSet::new();
        for obstacle in &obstacles {
            obstacles_set.insert((obstacle[0], obstacle[1]));
        }

        let mut queue = VecDeque::new();
        queue.push_back((start[0], start[1], 0));

        let mut visited = std::collections::HashSet::new();
        visited.insert((start[0], start[1]));

        let directions = vec![(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((x, y, steps)) = queue.pop_front() {
            if x == end[0] && y == end[1] {
                return steps;
            }

            for &(dx, dy) in &directions {
                let mut new_x = x;
                let mut new_y = y;

                while new_x >= 0 && new_x <= 200 && new_y >= 0 && new_y <= 200 {
                    new_x += dx;
                    new_y += dy;

                    if obstacles_set.contains(&(new_x, new_y)) {
                        break;
                    }

                    if !visited.contains(&(new_x, new_y)) {
                        visited.insert((new_x, new_y));
                        queue.push_back((new_x, new_y, steps + 1));
                    }
                }
            }
        }

        -1
    }
}