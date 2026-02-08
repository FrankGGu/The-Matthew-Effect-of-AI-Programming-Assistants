impl Solution {
    pub fn count_collisions(directions: String) -> i32 {
        let mut stack = Vec::new();
        let mut collisions = 0;

        for ch in directions.chars() {
            match ch {
                'L' => {
                    if let Some(&top) = stack.last() {
                        if top == 'R' {
                            collisions += 2;
                            stack.pop();
                            stack.push('S');
                            while let Some(&prev) = stack.last() {
                                if prev == 'R' {
                                    collisions += 1;
                                    stack.pop();
                                    stack.push('S');
                                } else {
                                    break;
                                }
                            }
                        } else if top == 'S' {
                            collisions += 1;
                            stack.push('S');
                        } else {
                            stack.push('L');
                        }
                    } else {
                        stack.push('L');
                    }
                },
                'R' => {
                    stack.push('R');
                },
                'S' => {
                    while let Some(&prev) = stack.last() {
                        if prev == 'R' {
                            collisions += 1;
                            stack.pop();
                            stack.push('S');
                        } else {
                            break;
                        }
                    }
                    stack.push('S');
                },
                _ => (),
            }
        }

        collisions
    }
}