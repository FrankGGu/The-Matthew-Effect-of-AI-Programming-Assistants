impl Solution {
    pub fn robot_collisions(s: Vec<i32>, d: Vec<i32>, dir: String) -> Vec<i32> {
        let n = s.len();
        let mut stack: Vec<(i32, i32, char)> = Vec::new();
        let mut ans: Vec<i32> = (0..n as i32).collect();
        let dirs: Vec<char> = dir.chars().collect();

        for i in 0..n {
            let pos = s[i];
            let health = d[i];
            let direction = dirs[i];

            if direction == 'R' {
                stack.push((pos, health, direction));
            } else {
                while !stack.is_empty() {
                    let (top_pos, top_health, top_dir) = stack.last().unwrap();
                    if top_dir == &'L' {
                        break;
                    }

                    if top_health > &health {
                        let top = stack.last_mut().unwrap();
                        top.1 -= 1;
                        ans[i] = -1;
                        break;
                    } else if top_health < &health {
                        stack.pop();
                        ans[*top_pos as usize] = -1;
                        d[i] -= 1;
                    } else {
                        stack.pop();
                        ans[*top_pos as usize] = -1;
                        ans[i] = -1;
                        break;
                    }
                }

                if ans[i] != -1 {
                    stack.push((pos, health, direction));
                }
            }
        }

        let mut result: Vec<i32> = Vec::new();
        for i in 0..n {
            if ans[i] != -1 {
                result.push(d[i]);
            }
        }

        result
    }
}