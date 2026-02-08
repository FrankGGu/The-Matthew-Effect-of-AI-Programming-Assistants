struct NumArray {
    nums: Vec<i32>,
    tree: Vec<i32>,
}

impl NumArray {
    fn new(nums: Vec<i32>) -> Self {
        let n = nums.len();
        let mut tree = vec![0; n + 1];
        let mut num_array = NumArray { nums, tree };

        for i in 0..num_array.nums.len() {
            num_array.update_tree(i + 1, num_array.nums[i]);
        }

        num_array
    }

    fn update_tree(&mut self, index: usize, delta: i32) {
        let mut idx = index;
        while idx < self.tree.len() {
            self.tree[idx] += delta;
            idx += idx & (-idx);
        }
    }

    fn update(&mut self, index: i32, val: i32) {
        let index = index as usize;
        let delta = val - self.nums[index];
        self.nums[index] = val;
        self.update_tree(index + 1, delta);
    }

    fn sum(&self, index: usize) -> i32 {
        let mut sum = 0;
        let mut idx = index + 1;
        while idx > 0 {
            sum += self.tree[idx];
            idx -= idx & (-idx);
        }
        sum
    }

    fn sum_range(&self, left: i32, right: i32) -> i32 {
        self.sum(right as usize) - self.sum((left - 1) as usize)
    }
}