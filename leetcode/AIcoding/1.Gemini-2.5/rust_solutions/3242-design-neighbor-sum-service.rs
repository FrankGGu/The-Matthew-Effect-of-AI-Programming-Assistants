struct NeighborSumService {
    nums: Vec<i32>,
    n: usize,
}

impl NeighborSumService {
    fn new(n: i32) -> Self {
        NeighborSumService {
            nums: vec![0; n as usize],
            n: n as usize,
        }
    }

    fn update(&mut self, index: i32, val: i32) {
        self.nums[index as usize] = val;
    }

    fn get_neighbor_sum(&self, index: i32) -> i32 {
        let idx = index as usize;
        let mut sum = 0;

        if self.n == 0 || self.n == 1 {
            return 0;
        }

        if idx == 0 {
            sum += self.nums[1];
        } else if idx == self.n - 1 {
            sum += self.nums[self.n - 2];
        } else {
            sum += self.nums[idx - 1];
            sum += self.nums[idx + 1];
        }
        sum
    }
}