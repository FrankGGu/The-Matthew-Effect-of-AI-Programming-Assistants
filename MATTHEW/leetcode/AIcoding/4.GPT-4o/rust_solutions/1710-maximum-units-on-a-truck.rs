impl Solution {
    pub fn maximum_units(boxes: Vec<Vec<i32>>, truck_size: i32) -> i32 {
        let mut boxes = boxes;
        boxes.sort_unstable_by(|a, b| b[1].cmp(&a[1]));

        let mut total_units = 0;
        let mut remaining_size = truck_size;

        for box_info in boxes {
            let count = box_info[0];
            let units = box_info[1];

            if remaining_size == 0 {
                break;
            }

            let take = count.min(remaining_size);
            total_units += take * units;
            remaining_size -= take;
        }

        total_units
    }
}