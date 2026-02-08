struct Solution {
    original: Vec<i32>,
    shuffled: Vec<i32>,
}

impl Solution {
    fn new(nums: Vec<i32>) -> Self {
        Self {
            original: nums.clone(),
            shuffled: nums,
        }
    }

    fn reset(&mut self) -> Vec<i32> {
        self.shuffled = self.original.clone();
        self.shuffled.clone()
    }

    fn shuffle(&mut self) -> Vec<i32> {
        use rand::seq::SliceRandom;
        let mut rng = rand::thread_rng();
        self.shuffled.shuffle(&mut rng);
        self.shuffled.clone()
    }
}