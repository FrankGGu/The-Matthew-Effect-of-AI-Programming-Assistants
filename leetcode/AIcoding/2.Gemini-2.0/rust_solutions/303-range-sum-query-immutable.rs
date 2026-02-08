struct NumArray {
    sums: Vec<i32>,
}

impl NumArray {
    fn new(nums: Vec<i32>) -> Self {
        let mut sums = vec![0; nums.len() + 1];
        for i in 0..nums.len() {
            sums[i + 1] = sums[i] + nums[i];
        }
        NumArray { sums }
    }

    fn sum_range(&self, left: i32, right: i32) -> i32 {
        self.sums[right as usize + 1] - self.sums[left as usize]
    }
}