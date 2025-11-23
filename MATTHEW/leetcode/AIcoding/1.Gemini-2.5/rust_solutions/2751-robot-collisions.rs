struct Robot {
    id: usize,
    position: i32,
    health: i32,
    direction: char,
}

impl Solution {
    pub fn robot_collisions(positions: Vec<i32>, healths: Vec<i32>, directions: String) -> Vec<i32> {
        let n = positions.len();
        let mut robots: Vec<Robot> = Vec::with_capacity(n);

        for i in 0..n {
            robots.push(Robot {
                id: i,
                position: positions[i],
                health: healths[i],
                direction: directions.chars().nth(i).unwrap(),
            });
        }

        robots.sort_by_key(|r| r.position);

        let mut stack: Vec<Robot> = Vec::new();

        for mut current_robot in robots {
            if current_robot.direction == 'R' {
                stack.push(current_robot);
            } else {
                while let Some(top_robot) = stack.last_mut() {
                    if top_robot.direction == 'R' {
                        if current_robot.health == top_robot.health {
                            stack.pop();
                            current_robot.health = 0;
                            break;
                        } else if current_robot.health > top_robot.health {
                            stack.pop();
                            current_robot.health -= 1;
                        } else {
                            top_robot.health -= 1;
                            current_robot.health = 0;
                            break;
                        }
                    } else {
                        break;
                    }
                }

                if current_robot.health > 0 {
                    stack.push(current_robot);
                }
            }
        }

        stack.sort_by_key(|r| r.id);

        stack.into_iter().map(|r| r.health).collect()
    }
}