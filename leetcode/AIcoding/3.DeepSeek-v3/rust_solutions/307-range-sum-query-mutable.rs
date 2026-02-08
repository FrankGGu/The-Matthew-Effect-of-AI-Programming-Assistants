struct NumArray {
    nums: Vec<i32>,
    tree: Vec<i32>,
    n: usize,
}

impl NumArray {
    fn new(nums: Vec<i32>) -> Self {
        let n = nums.len();
        let mut tree = vec![0; n + 1];
        for i in 0..n {
            let mut j = i + 1;
            while j <= n {
                tree[j] += nums[i];
                j += j & (!j + 1);
            }
        }
        NumArray { nums, tree, n }
    }

    fn update(&mut self, index: i32, val: i32) {
        let diff = val - self.nums[index as usize];
        self.nums[index as usize] = val;
        let mut j = index as usize + 1;
        while j <= self.n {
            self.tree[j] += diff;
            j += j & (!j + 1);
        }
    }

    fn sum_range(&self, left: i32, right: i32) -> i32 {
        self.sum(right as usize + 1) - self.sum(left as usize)
    }

    fn sum(&self, mut index: usize) -> i32 {
        let mut res = 0;
        while index > 0 {
            res += self.tree[index];
            index -= index & (!index + 1);
        }
        res
    }
}