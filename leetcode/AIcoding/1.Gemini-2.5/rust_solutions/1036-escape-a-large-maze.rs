use std::collections::{HashSet, VecDeque};

struct Solution;

impl Solution {
    const MAX_COORD: i32 = 1_000_000;
    const MAX_VISIT_COUNT: usize = 200 * 200; 

    fn can_escape_from_source(
        start: (i32, i32),
        target: (i32, i32),
        blocked_set: &HashSet<(i32, i32)>,
    ) -> bool {
        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();

        queue.push_back(start);
        visited.insert(start);

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        let mut count = 0;

        while let Some((r, c)) = queue.pop_front() {
            count += 1;
            if count > Self::MAX_VISIT_COUNT {
                return true;
            }

            if r == target.0 && c == target.1 {
                return true;
            }

            for (dr, dc) in directions.iter() {
                let nr = r + dr;
                let nc = c + dc;

                if nr < 0 || nr >= Self::MAX_COORD || nc < 0 || nc >= Self::MAX_COORD {
                    continue;
                }

                if blocked_set.contains(&(nr, nc)) {
                    continue;
                }

                if visited.contains(&(nr, nc)) {
                    continue;
                }

                visited.insert((nr, nc));
                queue.push_back((nr, nc));
            }
        }

        false
    }

    pub fn is_escape_possible(blocked: Vec<Vec<i32>>, source: Vec<i32>, target: Vec<i32>) -> bool {
        let mut blocked_set = HashSet::new();
        for b in blocked {
            blocked_set.insert((b[0], b[1]));
        }

        let source_tuple = (source[0], source[1]);
        let target_tuple = (target[0], target[1]);

        Self::can_escape_from_source(source_tuple, target_tuple, &blocked_set) &&
        Self::can_escape_from_source(target_tuple, source_tuple, &blocked_set)
    }
}