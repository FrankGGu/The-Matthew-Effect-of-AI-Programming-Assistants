impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn maximum_units(boxes: Vec<Vec<i32>>, truck_size: i32) -> i32 {
        let mut boxes = boxes;
        boxes.sort_by(|a, b| b[1].cmp(&a[1]));

        let mut total_units = 0;
        let mut remaining_capacity = truck_size;

        for box_ in boxes {
            let count = box_[0];
            let units = box_[1];

            if remaining_capacity <= 0 {
                break;
            }

            let take = count.min(remaining_capacity);
            total_units += take * units;
            remaining_capacity -= take;
        }

        total_units
    }
}

pub struct Solution;
}