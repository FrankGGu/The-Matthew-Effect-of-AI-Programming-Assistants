impl Solution {
    pub fn minimum_size(bags: Vec<i32>, max_undo: i32) -> i32 {
        let mut left = 1;
        let mut right = *bags.iter().max().unwrap();

        while left < right {
            let mid = (left + right) / 2;
            let total_moves: i32 = bags.iter().map(|&x| (x + mid - 1) / mid - 1).sum();

            if total_moves <= max_undo {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}