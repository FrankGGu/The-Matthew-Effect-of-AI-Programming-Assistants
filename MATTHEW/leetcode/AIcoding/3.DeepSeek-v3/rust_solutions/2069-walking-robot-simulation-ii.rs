struct Robot {
    width: i32,
    height: i32,
    pos: (i32, i32),
    dir: usize,
    dirs: Vec<(i32, i32)>,
    dir_names: Vec<String>,
}

impl Robot {
    fn new(width: i32, height: i32) -> Self {
        let dirs = vec![(1, 0), (0, 1), (-1, 0), (0, -1)];
        let dir_names = vec!["East", "North", "West", "South"]
            .into_iter()
            .map(|s| s.to_string())
            .collect();
        Robot {
            width,
            height,
            pos: (0, 0),
            dir: 0,
            dirs,
            dir_names,
        }
    }

    fn step(&mut self, num: i32) {
        let mut num = num % (2 * (self.width + self.height - 2));
        if num == 0 {
            num = 2 * (self.width + self.height - 2);
        }
        for _ in 0..num {
            let next_pos = (self.pos.0 + self.dirs[self.dir].0, self.pos.1 + self.dirs[self.dir].1);
            if next_pos.0 < 0 || next_pos.0 >= self.width || next_pos.1 < 0 || next_pos.1 >= self.height {
                self.dir = (self.dir + 1) % 4;
                self.pos = (self.pos.0 + self.dirs[self.dir].0, self.pos.1 + self.dirs[self.dir].1);
            } else {
                self.pos = next_pos;
            }
        }
    }

    fn get_pos(&self) -> Vec<i32> {
        vec![self.pos.0, self.pos.1]
    }

    fn get_dir(&self) -> String {
        self.dir_names[self.dir].clone()
    }
}