impl Solution {
    pub fn maximum_units(mut box_types: Vec<Vec<i32>>, truck_size: i32) -> i32 {
        box_types.sort_unstable_by(|a, b| b[1].cmp(&a[1]));

        let mut total_units = 0;
        let mut remaining_capacity = truck_size;

        for box_type in box_types {
            let num_boxes = box_type[0];
            let units_per_box = box_type[1];

            if remaining_capacity <= 0 {
                break;
            }

            let boxes_to_load = num_boxes.min(remaining_capacity);

            total_units += boxes_to_load * units_per_box;
            remaining_capacity -= boxes_to_load;
        }

        total_units
    }
}