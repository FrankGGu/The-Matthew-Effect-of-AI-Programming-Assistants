struct NeighborSumService {
    nums: Vec<i32>,
}

impl NeighborSumService {
    fn new(nums: Vec<i32>) -> Self {
        NeighborSumService { nums }
    }

    fn update(&mut self, index: i32, val: i32) {
        self.nums[index as usize] = val;
    }

    fn sum(&self, index: i32, k: i32) -> i32 {
        let index = index as usize;
        let k = k as usize;
        let left = if index >= k { index - k } else { 0 };
        let right = if index + k < self.nums.len() { index + k } else { self.nums.len() - 1 };
        self.nums[left..=right].iter().sum()
    }
}