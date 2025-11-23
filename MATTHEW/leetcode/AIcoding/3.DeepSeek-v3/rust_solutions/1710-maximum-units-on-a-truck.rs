impl Solution {
    pub fn maximum_units(box_types: Vec<Vec<i32>>, truck_size: i32) -> i32 {
        let mut box_types = box_types;
        box_types.sort_by(|a, b| b[1].cmp(&a[1]));
        let mut units = 0;
        let mut remaining = truck_size;
        for box_type in box_types {
            let take = std::cmp::min(box_type[0], remaining);
            units += take * box_type[1];
            remaining -= take;
            if remaining == 0 {
                break;
            }
        }
        units
    }
}