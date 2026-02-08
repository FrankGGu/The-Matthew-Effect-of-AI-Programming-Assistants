struct Solution {
    prefix_sums: Vec<i32>,
    total: i32,
}

impl Solution {
    fn new(w: Vec<i32>) -> Self {
        let mut prefix_sums = Vec::with_capacity(w.len());
        let mut total = 0;
        for &num in &w {
            total += num;
            prefix_sums.push(total);
        }
        Solution { prefix_sums, total }
    }

    fn pick_index(&self) -> i32 {
        let target = rand::random::<i32>() % self.total;
        let mut left = 0;
        let mut right = self.prefix_sums.len() as i32 - 1;
        while left < right {
            let mid = left + (right - left) / 2;
            if self.prefix_sums[mid as usize] <= target {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        left
    }
}