impl Solution {
    pub fn building_boxes(n: i32) -> i32 {
        let n_i64 = n as i64;

        // Step 1: Find the largest `h_base` such that a tetrahedral pyramid of height `h_base`
        // can store `h_base * (h_base + 1) * (h_base + 2) / 6` boxes, which is less than or equal to `n`.
        // This `h_base` represents the "depth" of the largest full tetrahedral structure.
        // The number of floor boxes used by this structure is `h_base * (h_base + 1) / 2`.
        let mut h_base: i64 = 0;
        loop {
            let next_h_base = h_base + 1;
            // Calculate boxes in a tetrahedral pyramid of height `next_h_base`.
            // Using i64 for calculation to prevent overflow for intermediate products, though for h_base ~1817, it's fine.
            let boxes_if_h_base_is_next = next_h_base * (next_h_base + 1) * (next_h_base + 2) / 6;

            if boxes_if_h_base_is_next > n_i64 {
                break;
            }
            h_base = next_h_base;
        }

        // Calculate total boxes stored and floor boxes used by this largest full tetrahedral pyramid.
        let boxes_in_tetra_pyramid = h_base * (h_base + 1) * (h_base + 2) / 6;
        let mut total_floor_boxes: i64 = h_base * (h_base + 1) / 2;

        // Step 2: Calculate the remaining boxes that still need to be placed.
        let remaining_n = n_i64 - boxes_in_tetra_pyramid;

        // Step 3: If there are remaining boxes, place them efficiently.
        if remaining_n > 0 {
            // We need to place `remaining_n` boxes.
            // We can do this by building a "triangular prism pyramid" on top of the existing structure.
            // The base of this new pyramid will have `k_add` boxes.
            // We need to find the smallest `k_add` such that `k_add * (k_add + 1) / 2 >= remaining_n`.
            // This `k_add` is the height of this new pyramid.
            let remaining_n_f64 = remaining_n as f64;
            let k_add_f64 = (-1.0 + (1.0 + 8.0 * remaining_n_f64).sqrt()) / 2.0;
            let k_add = k_add_f64.ceil() as i64;

            // The `h_base` value represents the "width" of the top layer of the base of the tetrahedral pyramid.
            // This means we have `h_base` available slots on the top layer of the base to stack new boxes without adding new floor boxes.
            // If `k_add` (the base of the new pyramid) is less than or equal to `h_base`,
            // then all `k_add` boxes can be placed on existing boxes, requiring no additional floor boxes.
            // If `k_add` is greater than `h_base`, we need `k_add - h_base` additional floor boxes.
            if k_add > h_base {
                total_floor_boxes += k_add - h_base;
            }
        }

        total_floor_boxes as i32
    }
}