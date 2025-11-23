impl Solution {
    pub fn min_wasted_space(mut packages: Vec<i32>, suppliers: Vec<Vec<i32>>) -> i64 {
        const MOD: i64 = 1_000_000_007;

        packages.sort_unstable(); // Sort packages for efficient processing

        // Calculate prefix sums for packages
        let mut prefix_sums: Vec<i64> = vec![0; packages.len() + 1];
        for i in 0..packages.len() {
            prefix_sums[i + 1] = prefix_sums[i] + packages[i] as i64;
        }

        let mut min_total_waste: i64 = i64::MAX;

        for mut supplier_packages in suppliers {
            supplier_packages.sort_unstable(); // Sort supplier's packages

            // Optimization: If the largest package from this supplier cannot hold the largest item,
            // this supplier cannot package all items.
            if supplier_packages.last().unwrap() < packages.last().unwrap() {
                continue;
            }

            let mut current_supplier_waste: i64 = 0;
            let mut package_ptr: usize = 0; // Pointer for packages array

            for &box_size in &supplier_packages {
                if package_ptr == packages.len() {
                    break; // All items are already packaged
                }

                // Find the index of the first package that is strictly greater than box_size
                // All packages from package_ptr up to this index (exclusive) can be stored in box_size
                let next_package_ptr = packages[package_ptr..]
                    .partition_point(|&p| p <= box_size) + package_ptr;

                let num_items_in_this_box = (next_package_ptr - package_ptr) as i64;
                if num_items_in_this_box > 0 {
                    let sum_of_these_items = prefix_sums[next_package_ptr] - prefix_sums[package_ptr];
                    let waste_for_this_box = (num_items_in_this_box * box_size as i64) - sum_of_these_items;
                    current_supplier_waste = (current_supplier_waste + waste_for_this_box) % MOD;
                }

                package_ptr = next_package_ptr;
            }

            // If not all packages were processed by this supplier, it's invalid
            if package_ptr < packages.len() {
                continue;
            }

            min_total_waste = min_total_waste.min(current_supplier_waste);
        }

        if min_total_waste == i64::MAX {
            -1
        } else {
            min_total_waste
        }
    }
}