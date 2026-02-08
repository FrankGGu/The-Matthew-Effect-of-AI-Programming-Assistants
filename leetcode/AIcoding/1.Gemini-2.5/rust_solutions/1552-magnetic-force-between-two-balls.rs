impl Solution {
    pub fn max_distance(mut position: Vec<i32>, m: i32) -> i32 {
        position.sort_unstable();

        let n = position.len();
        let mut low = 1;
        let mut high = position[n - 1] - position[0];
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, &position, m) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }

    fn check(force: i32, position: &[i32], m: i32) -> bool {
        let mut balls_placed = 1;
        let mut last_placed_pos = position[0];

        for i in 1..position.len() {
            if position[i] - last_placed_pos >= force {
                balls_placed += 1;
                last_placed_pos = position[i];
                if balls_placed == m {
                    return true;
                }
            }
        }
        balls_placed >= m
    }
}