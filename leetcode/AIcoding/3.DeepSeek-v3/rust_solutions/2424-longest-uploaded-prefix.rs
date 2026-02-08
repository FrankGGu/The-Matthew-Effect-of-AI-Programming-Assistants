struct LUPrefix {
    uploaded: Vec<bool>,
    prefix: usize,
}

impl LUPrefix {
    fn new(n: i32) -> Self {
        LUPrefix {
            uploaded: vec![false; n as usize + 1],
            prefix: 0,
        }
    }

    fn upload(&mut self, video: i32) {
        let video = video as usize;
        self.uploaded[video] = true;
        while self.prefix + 1 < self.uploaded.len() && self.uploaded[self.prefix + 1] {
            self.prefix += 1;
        }
    }

    fn longest(&self) -> i32 {
        self.prefix as i32
    }
}