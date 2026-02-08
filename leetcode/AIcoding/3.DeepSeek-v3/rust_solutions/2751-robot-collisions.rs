impl Solution {
    pub fn survived_robots_healths(positions: Vec<i32>, healths: Vec<i32>, directions: String) -> Vec<i32> {
        let n = positions.len();
        let mut robots: Vec<(i32, i32, char, usize)> = positions
            .into_iter()
            .zip(healths.into_iter())
            .zip(directions.chars())
            .enumerate()
            .map(|(i, ((pos, health), dir))| (pos, health, dir, i))
            .collect();
        robots.sort_by_key(|&(pos, _, _, _)| pos);

        let mut stack: Vec<(i32, char, usize)> = Vec::new();
        for &(_, health, dir, idx) in &robots {
            let mut current_health = health;
            let mut current_dir = dir;
            let mut current_idx = idx;

            while let Some(&(top_health, top_dir, top_idx)) = stack.last() {
                if top_dir == 'R' && current_dir == 'L' {
                    if top_health > current_health {
                        current_health = 0;
                        stack.pop();
                        stack.push((top_health - 1, top_dir, top_idx));
                        break;
                    } else if top_health < current_health {
                        current_health -= 1;
                        stack.pop();
                    } else {
                        current_health = 0;
                        stack.pop();
                        break;
                    }
                } else {
                    break;
                }
            }

            if current_health > 0 {
                stack.push((current_health, current_dir, current_idx));
            }
        }

        stack.sort_by_key(|&(_, _, idx)| idx);
        stack.into_iter().map(|(health, _, _)| health).collect()
    }
}