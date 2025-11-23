struct Robot {
    width: i32,
    height: i32,
    x: i32,
    y: i32,
    dir: i32, // 0: East, 1: North, 2: West, 3: South
    perimeter: i32,
}

impl Robot {
    fn new(width: i32, height: i32) -> Self {
        Robot {
            width,
            height,
            x: 0,
            y: 0,
            dir: 0,
            perimeter: 2 * (width + height) - 4,
        }
    }

    fn step(&mut self, num: i32) {
        let num = num % self.perimeter;
        if num == 0 {
            return;
        }

        let mut steps = num;

        while steps > 0 {
            match self.dir {
                0 => { // East
                    if self.x + steps < self.width {
                        self.x += steps;
                        steps = 0;
                    } else {
                        steps -= self.width - 1 - self.x;
                        self.x = self.width - 1;
                        self.dir = 1;
                    }
                }
                1 => { // North
                    if self.y + steps < self.height {
                        self.y += steps;
                        steps = 0;
                    } else {
                        steps -= self.height - 1 - self.y;
                        self.y = self.height - 1;
                        self.dir = 2;
                    }
                }
                2 => { // West
                    if self.x - steps >= 0 {
                        self.x -= steps;
                        steps = 0;
                    } else {
                        steps -= self.x;
                        self.x = 0;
                        self.dir = 3;
                    }
                }
                3 => { // South
                    if self.y - steps >= 0 {
                        self.y -= steps;
                        steps = 0;
                    } else {
                        steps -= self.y;
                        self.y = 0;
                        self.dir = 0;
                    }
                }
                _ => {}
            }
        }
    }

    fn get_pos(&self) -> Vec<i32> {
        vec![self.x, self.y]
    }

    fn get_dir(&self) -> String {
        match self.dir {
            0 => "East".to_string(),
            1 => "North".to_string(),
            2 => "West".to_string(),
            3 => "South".to_string(),
            _ => "".to_string(),
        }
    }
}