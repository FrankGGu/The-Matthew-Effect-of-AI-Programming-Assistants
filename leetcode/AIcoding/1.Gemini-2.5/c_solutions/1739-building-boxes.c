long long buildingBoxes(int n) {
    long long N = n;

    long long k = 0; // k represents the side length of the base of the largest full pyramid
    long long total_boxes_in_pyramid = 0;

    // Find the largest k such that a full pyramid of height k (and base side k)
    // has a total number of boxes less than or equal to N.
    // The total number of boxes in such a pyramid (P_k) is k * (k + 1) * (k + 2) / 6.
    while (1) {
        long long next_k = k + 1;

        // Calculate P_{next_k} = next_k * (next_k + 1) * (next_k + 2) / 6
        // Check for potential overflow if next_k is very large, though for N=10^9,
        // next_k max is around 1817, so the product fits in long long.
        long long boxes_if_next_pyramid_full = next_k * (next_k + 1) / 2; // This is the size of the next base layer

        // To calculate P_{next_k} without directly using the large product:
        // P_{next_k} = P_k + (next_k * (next_k + 1) / 2)
        // No, this is incorrect. P_k is the sum of layers of a pyramid of height k.
        // The formula for P_k is sum_{i=1 to k} (i * (i+1) / 2).
        // Let's use the direct formula for P_k.
        long long current_pyramid_total_boxes = next_k * (next_k + 1) * (next_k + 2) / 6;

        if (current_pyramid_total_boxes <= N) {
            k = next_k;
            total_boxes_in_pyramid = current_pyramid_total_boxes;
        } else {
            break;
        }
    }

    // The minimum number of boxes touching the floor for this full pyramid is k * (k + 1) / 2.
    long long ans_floor_boxes = k * (k + 1) / 2;
    long long remaining_n = N - total_boxes_in_pyramid;

    // We have 'remaining_n' boxes left to place.
    // These boxes should be placed on top of the existing pyramid to minimize floor boxes.
    // They will form new layers (or partial layers) above the current pyramid.
    // These boxes do not touch the floor.
    // The number of boxes that can be placed in the next layer (at height k) is (k+1) * (k+2) / 2.
    // Since 'remaining_n' will always be less than or equal to the capacity of the next layer
    // (or subsequent layers if it were a much larger number), these boxes will not force
    // an expansion of the base.
    // For example, if N = 10^9, k is approx 1816.
    // P_1816 is approx 10^9. The next layer (k+1) can hold (1816+1)*(1816+2)/2 = 1817*1818/2 = 1,649,836 boxes.
    // The maximum remaining_n is less than this (e.g., N - P_k_max is at most P_{k+1} - P_k - 1, which is the size of the next layer minus 1).
    // So, all remaining boxes can be placed on top without increasing the floor area.

    return ans_floor_boxes;
}