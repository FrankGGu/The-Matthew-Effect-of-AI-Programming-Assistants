#include <stdlib.h> // For qsort
#include <limits.h> // For LLONG_MAX

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long min(long long a, long long b) {
    return (a < b) ? a : b;
}

long long minSpaceWastedFromPackaging(int* packages, int packagesSize, int** boxes, int boxesSize, int* boxesColSize) {
    long long MOD = 1000000007;

    // 1. Sort the packages array in ascending order.
    // This allows efficient matching with sorted boxes.
    qsort(packages, packagesSize, sizeof(int), compare);

    // 2. Calculate prefix sums for the sorted packages array.
    // This allows O(1) calculation of sum of package sizes within a range.
    long long* prefix_sum_packages = (long long*)malloc((packagesSize + 1) * sizeof(long long));
    prefix_sum_packages[0] = 0;
    for (int j = 0; j < packagesSize; j++) {
        prefix_sum_packages[j+1] = prefix_sum_packages[j] + packages[j];
    }

    long long min_total_wasted_space = LLONG_MAX; // Initialize with a very large value

    // 3. Iterate through each supplier (each set of boxes)
    for (int i = 0; i < boxesSize; i++) {
        int* current_supplier_boxes = boxes[i];
        int current_supplier_boxesSize = boxesColSize[i];

        // a. Sort the current supplier's boxes in ascending order.
        qsort(current_supplier_boxes, current_supplier_boxesSize, sizeof(int), compare);

        long long current_supplier_wasted_space = 0;
        int package_ptr = 0; // Pointer for iterating through packages
        int box_ptr = 0;     // Pointer for iterating through current_supplier_boxes
        int possible_to_pack_all = 1; // Flag to track if all packages can be packed by this supplier

        // b. Calculate the wasted space for the current supplier
        while (package_ptr < packagesSize) {
            // Find the smallest box from the current supplier that can fit packages[package_ptr].
            // Advance box_ptr past boxes that are too small.
            while (box_ptr < current_supplier_boxesSize && current_supplier_boxes[box_ptr] < packages[package_ptr]) {
                box_ptr++;
            }

            // If box_ptr reaches the end of current_supplier_boxes, it means no box can fit
            // the current package (or any subsequent packages). This supplier is invalid.
            if (box_ptr == current_supplier_boxesSize) {
                possible_to_pack_all = 0;
                break;
            }

            // current_supplier_boxes[box_ptr] is the smallest box that fits packages[package_ptr].
            long long current_box_size = current_supplier_boxes[box_ptr];

            // Find how many packages can fit into this specific box (current_box_size).
            // 'temp_package_ptr' will find the upper bound of packages that fit.
            int temp_package_ptr = package_ptr;
            while (temp_package_ptr < packagesSize && packages[temp_package_ptr] <= current_box_size) {
                temp_package_ptr++;
            }

            // Calculate the number of packages that fit into this box.
            long long packages_in_this_box_count = temp_package_ptr - package_ptr;

            // Calculate the sum of sizes of packages that fit into this box using prefix sums.
            long long sum_of_packages_in_this_box = prefix_sum_packages[temp_package_ptr] - prefix_sum_packages[package_ptr];

            // Add the wasted space for this box to the total for the current supplier.
            // Wasted space = (number of packages * box size) - sum of package sizes.
            current_supplier_wasted_space += packages_in_this_box_count * current_box_size - sum_of_packages_in_this_box;

            // Move package_ptr to the next package that has not yet been packed.
            package_ptr = temp_package_ptr;

            // Move to the next box, as the current box has been used for all fitting packages.
            box_ptr++;
        }

        // If this supplier successfully packed all packages, update the minimum total wasted space.
        if (possible_to_pack_all) {
            min_total_wasted_space = min(min_total_wasted_space, current_supplier_wasted_space);
        }
    }

    // Free the allocated memory for prefix sums.
    free(prefix_sum_packages);

    // 4. Return the result.
    // If min_total_wasted_space is still LLONG_MAX, it means no supplier could pack all packages.
    if (min_total_wasted_space == LLONG_MAX) {
        return -1;
    } else {
        // Return the minimum total wasted space modulo 10^9 + 7.
        return min_total_wasted_space % MOD;
    }
}