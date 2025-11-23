impl Solution {
    pub fn min_wasted_space(packages: Vec<i32>, boxes: Vec<Vec<i32>>) -> i32 {
        let mut packages = packages;
        packages.sort();
        let total: i32 = packages.iter().sum();
        let mut min_waste = i32::MAX;

        for box_sizes in boxes {
            if box_sizes.len() < 1 || box_sizes[0] < packages[0] {
                continue;
            }
            let mut waste = 0;
            let mut j = 0;
            let mut box_capacity = 0;

            for size in box_sizes {
                let mut current_capacity = 0;
                while j < packages.len() && packages[j] <= size {
                    current_capacity += packages[j];
                    j += 1;
                }
                waste += size * (j as i32) - current_capacity;
            }

            if j == packages.len() {
                min_waste = min_waste.min(waste);
            }
        }

        if min_waste == i32::MAX {
            return -1;
        }
        min_waste
    }
}