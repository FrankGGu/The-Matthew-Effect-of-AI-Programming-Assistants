pub fn robot_collisions(robots: Vec<i32>) -> Vec<i32> {
    let mut stack: Vec<i32> = Vec::new();
    for &robot in robots.iter() {
        if robot > 0 {
            stack.push(robot);
        } else {
            while let Some(&last) = stack.last() {
                if last < -robot {
                    stack.pop();
                } else {
                    if last == -robot {
                        stack.pop();
                    }
                    break;
                }
            }
            if stack.is_empty() || stack.last() < Some(&0) {
                stack.push(robot);
            }
        }
    }
    stack
}