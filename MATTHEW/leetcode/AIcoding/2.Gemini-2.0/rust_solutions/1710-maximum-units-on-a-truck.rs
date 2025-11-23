impl Solution {
    pub fn maximum_units(mut box_types: Vec<Vec<i32>>, truck_size: i32) -> i32 {
        box_types.sort_by(|a, b| b[1].cmp(&a[1]));
        let mut total_units = 0;
        let mut remaining_truck_size = truck_size;

        for box_type in box_types {
            let num_boxes = box_type[0];
            let units_per_box = box_type[1];

            if remaining_truck_size >= num_boxes {
                total_units += num_boxes * units_per_box;
                remaining_truck_size -= num_boxes;
            } else {
                total_units += remaining_truck_size * units_per_box;
                break;
            }
        }

        total_units
    }
}