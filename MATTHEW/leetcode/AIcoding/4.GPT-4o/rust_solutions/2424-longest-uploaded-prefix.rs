use std::collections::HashMap;

struct LUPrefix {
    videos: HashMap<i32, bool>,
    max_uploaded: i32,
}

impl LUPrefix {
    fn new(n: i32) -> Self {
        LUPrefix {
            videos: HashMap::new(),
            max_uploaded: 0,
        }
    }

    fn upload(&mut self, video: i32) {
        self.videos.insert(video, true);
    }

    fn longest(&mut self) -> i32 {
        while self.videos.contains_key(&(self.max_uploaded + 1)) {
            self.max_uploaded += 1;
        }
        self.max_uploaded
    }
}