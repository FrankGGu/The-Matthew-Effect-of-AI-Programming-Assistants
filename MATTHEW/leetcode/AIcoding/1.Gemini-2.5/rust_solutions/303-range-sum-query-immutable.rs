struct NumArray {
    prefix_sums: Vec<i32>,
}

impl NumArray {
    fn new(nums: Vec<i32>) -> Self {
        let mut prefix_sums = vec![0; nums.len() + 1];
        for i in 0..nums.len() {
            prefix_sums[i + 1] = prefix_sums[i] + nums[i];
        }
        NumArray { prefix_sums }
    }

    fn sum_range(&self, left: i32, right: i32) -> i32 {
        let left = left as usize;
        let right = right as usize;
        self.prefix_sums[right + 1] - self.prefix_sums[left]
    }
}