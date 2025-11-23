use rand::Rng;

struct Solution {
    nums: Vec<i32>,
}

impl Solution {
    fn new(nums: Vec<i32>) -> Self {
        Solution { nums }
    }

    fn pick(&self, target: i32) -> i32 {
        let mut rng = rand::thread_rng();
        let mut count = 0;
        let mut result = -1;

        for (i, &num) in self.nums.iter().enumerate() {
            if num == target {
                count += 1;
                if rng.gen_range(0..count) == 0 {
                    result = i as i32;
                }
            }
        }
        result
    }
}