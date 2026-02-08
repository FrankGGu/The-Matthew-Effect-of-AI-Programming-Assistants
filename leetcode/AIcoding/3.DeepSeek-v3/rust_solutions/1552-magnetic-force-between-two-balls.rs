impl Solution {
    pub fn max_distance(position: Vec<i32>, m: i32) -> i32 {
        let mut position = position;
        position.sort_unstable();
        let mut left = 1;
        let mut right = position.last().unwrap() - position[0];
        let mut answer = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            if Self::can_place_balls(&position, m, mid) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        answer
    }

    fn can_place_balls(position: &[i32], m: i32, min_force: i32) -> bool {
        let mut count = 1;
        let mut last_pos = position[0];

        for &pos in position.iter().skip(1) {
            if pos - last_pos >= min_force {
                count += 1;
                last_pos = pos;
                if count >= m {
                    return true;
                }
            }
        }

        count >= m
    }
}