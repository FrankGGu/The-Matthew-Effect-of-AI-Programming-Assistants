struct NumArray {
    nums: Vec<i32>,
    prefix_sum: Vec<i32>,
}

impl NumArray {
    fn new(nums: Vec<i32>) -> Self {
        let mut prefix_sum = vec![0; nums.len() + 1];
        for i in 0..nums.len() {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }
        NumArray { nums, prefix_sum }
    }

    fn update(&mut self, index: usize, val: i32) {
        let diff = val - self.nums[index];
        self.nums[index] = val;
        for i in index + 1..self.prefix_sum.len() {
            self.prefix_sum[i] += diff;
        }
    }

    fn sum_range(&self, left: usize, right: usize) -> i32 {
        self.prefix_sum[right + 1] - self.prefix_sum[left]
    }
}