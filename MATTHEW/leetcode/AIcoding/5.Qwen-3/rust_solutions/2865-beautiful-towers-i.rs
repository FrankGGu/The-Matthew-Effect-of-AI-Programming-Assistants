impl Solution {

use std::cmp::Ordering;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Direction {
    Left,
    Right,
}

pub struct Solution {}

impl Solution {
    pub fn get_heights(towers: Vec<i32>, direction: Direction) -> Vec<i32> {
        let n = towers.len();
        let mut result = vec![0; n];

        match direction {
            Direction::Left => {
                for i in 0..n {
                    if i == 0 {
                        result[i] = towers[i];
                    } else {
                        match towers[i].cmp(&towers[i - 1]) {
                            Ordering::Greater => result[i] = towers[i],
                            _ => result[i] = result[i - 1],
                        }
                    }
                }
            },
            Direction::Right => {
                for i in (0..n).rev() {
                    if i == n - 1 {
                        result[i] = towers[i];
                    } else {
                        match towers[i].cmp(&towers[i + 1]) {
                            Ordering::Greater => result[i] = towers[i],
                            _ => result[i] = result[i + 1],
                        }
                    }
                }
            },
        }

        result
    }
}
}