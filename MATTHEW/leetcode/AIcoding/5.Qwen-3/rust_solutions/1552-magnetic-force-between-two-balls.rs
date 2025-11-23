impl Solution {

use std::cmp::max;

struct Solution;

impl Solution {
    pub fn max_distance(mut positions: Vec<i32>, mut m: i32) -> i32 {
        positions.sort();
        let (mut left, mut right) = (0, positions.last().unwrap() - positions.first().unwrap());
        let mut answer = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            if Self::can_place_balls(&positions, mid, m) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        answer
    }

    fn can_place_balls(positions: &Vec<i32>, distance: i32, m: i32) -> bool {
        let mut count = 1;
        let mut last_position = positions[0];

        for &pos in positions.iter().skip(1) {
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
}