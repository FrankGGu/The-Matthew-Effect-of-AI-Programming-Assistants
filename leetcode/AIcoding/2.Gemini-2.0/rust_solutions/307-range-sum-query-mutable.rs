struct NumArray {
    nums: Vec<i32>,
    bit: Vec<i32>,
    n: usize,
}

impl NumArray {
    fn new(nums: Vec<i32>) -> Self {
        let n = nums.len();
        let mut bit = vec![0; n + 1];
        let mut obj = NumArray {
            nums: nums.clone(),
            bit,
            n,
        };
        for i in 0..n {
            obj.update(i as i32, nums[i]);
        }
        obj
    }

    fn update(&mut self, index: i32, val: i32) {
        let diff = val - self.nums[index as usize];
        self.nums[index as usize] = val;
        let mut i = index as usize + 1;
        while i <= self.n {
            self.bit[i] += diff;
            i += i & (!i + 1);
        }
    }

    fn sum_range(&self, left: i32, right: i32) -> i32 {
        self.prefix_sum(right as usize) - self.prefix_sum(left as usize - 1)
    }

    fn prefix_sum(&self, index: usize) -> i32 {
        let mut sum = 0;
        let mut i = index + 1;
        while i > 0 {
            sum += self.bit[i];
            i -= i & (!i + 1);
        }
        sum
    }
}