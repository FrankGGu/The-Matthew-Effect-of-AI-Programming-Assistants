use rand::Rng;

struct Solution {
    nums: Vec<i32>,
}

impl Solution {
    fn new(nums: Vec<i32>) -> Self {
        Solution { nums }
    }

    fn pick(&self, target: i32) -> i32 {
        let mut indices = Vec::new();
        for (i, &num) in self.nums.iter().enumerate() {
            if num == target {
                indices.push(i as i32);
            }
        }

        let mut rng = rand::thread_rng();
        let index = rng.gen_range(0..indices.len());
        indices[index]
    }
}