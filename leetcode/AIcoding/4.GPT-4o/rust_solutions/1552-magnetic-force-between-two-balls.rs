impl Solution {
    pub fn max_distance(position: Vec<i32>, m: i32) -> i32 {
        let mut position = position;
        position.sort();
        let (mut left, mut right) = (1, position[position.len() - 1] - position[0]);

        while left < right {
            let mid = right - (right - left) / 2;
            if Self::can_place(&position, mid, m) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        left
    }

    fn can_place(position: &Vec<i32>, distance: i32, m: i32) -> bool {
        let mut count = 1;
        let mut last_position = position[0];

        for &pos in position.iter().skip(1) {
            if pos - last_position >= distance {
                count += 1;
                last_position = pos;
                if count >= m {
                    return true;
                }
            }
        }

        count >= m
    }
}