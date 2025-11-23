struct LongestUploadedPrefix {
    uploaded_status: Vec<bool>,
    current_longest_prefix: i32,
    n: i32,
}

impl LongestUploadedPrefix {
    fn new(n: i32) -> Self {
        LongestUploadedPrefix {
            uploaded_status: vec![false; n as usize],
            current_longest_prefix: 0,
            n,
        }
    }

    fn upload(&mut self, video: i32) {
        self.uploaded_status[(video - 1) as usize] = true;

        while self.current_longest_prefix < self.n && self.uploaded_status[self.current_longest_prefix as usize] {
            self.current_longest_prefix += 1;
        }
    }

    fn longest(&self) -> i32 {
        self.current_longest_prefix
    }
}