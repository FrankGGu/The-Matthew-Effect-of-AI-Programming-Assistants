impl Solution {
    pub fn min_wasted_space(packets: Vec<i32>, boxes: Vec<Vec<i32>>) -> i32 {
        let total: i32 = packets.iter().sum();
        let mut packets = packets;
        packets.sort();
        let mut result = i32::MAX;

        for box_sizes in boxes {
            if box_sizes.len() < packets.len() {
                continue;
            }
            let mut box_sizes = box_sizes;
            box_sizes.sort();
            let mut waste = 0;
            let mut j = 0;
            let mut valid = true;

            for &size in &box_sizes {
                let mut current_waste = 0;
                while j < packets.len() && packets[j] <= size {
                    current_waste += packets[j];
                    j += 1;
                }
                waste += size * (j as i32) - current_waste;
            }

            if valid && j == packets.len() {
                result = result.min(waste);
            }
        }

        if result == i32::MAX {
            -1
        } else {
            result
        }
    }
}