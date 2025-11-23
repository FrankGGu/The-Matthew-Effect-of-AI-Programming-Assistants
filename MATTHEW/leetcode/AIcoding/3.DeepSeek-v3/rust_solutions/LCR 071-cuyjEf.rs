use rand::Rng;

struct Solution {
    prefix_sum: Vec<i32>,
    total: i32,
}

impl Solution {
    fn new(w: Vec<i32>) -> Self {
        let mut prefix_sum = Vec::with_capacity(w.len());
        let mut sum = 0;
        for &num in &w {
            sum += num;
            prefix_sum.push(sum);
        }
        Solution {
            prefix_sum,
            total: sum,
        }
    }

    fn pick_index(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let target = rng.gen_range(1..=self.total);
        let (mut left, mut right) = (0, self.prefix_sum.len() as i32 - 1);
        while left < right {
            let mid = left + (right - left) / 2;
            if self.prefix_sum[mid as usize] < target {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        left
    }
}