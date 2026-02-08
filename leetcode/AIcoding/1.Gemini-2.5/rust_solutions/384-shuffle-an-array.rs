use rand::seq::SliceRandom;
use rand::thread_rng;

struct Solution {
    original: Vec<i32>,
}

impl Solution {
    fn new(nums: Vec<i32>) -> Self {
        Solution {
            original: nums,
        }
    }

    fn reset(&self) -> Vec<i32> {
        self.original.clone()
    }

    fn shuffle(&self) -> Vec<i32> {
        let mut shuffled = self.original.clone();
        let mut rng = thread_rng();
        shuffled.shuffle(&mut rng);
        shuffled
    }
}