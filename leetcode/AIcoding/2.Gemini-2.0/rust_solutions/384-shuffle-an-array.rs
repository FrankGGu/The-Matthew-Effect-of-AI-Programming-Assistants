use rand::Rng;

struct Solution {
    nums: Vec<i32>,
    original: Vec<i32>,
}

impl Solution {
    fn new(nums: Vec<i32>) -> Self {
        Solution {
            nums: nums.clone(),
            original: nums,
        }
    }

    fn reset(&mut self) -> Vec<i32> {
        self.nums = self.original.clone();
        self.nums.clone()
    }

    fn shuffle(&mut self) -> Vec<i32> {
        let mut rng = rand::thread_rng();
        let n = self.nums.len();
        for i in 0..n {
            let j = rng.gen_range(i..n);
            self.nums.swap(i, j);
        }
        self.nums.clone()
    }
}