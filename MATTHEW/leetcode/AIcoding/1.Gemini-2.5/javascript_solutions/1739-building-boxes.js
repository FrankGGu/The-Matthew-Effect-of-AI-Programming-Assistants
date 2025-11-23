var minimumBoxes = function(n) {
    let h_val = 0; // Represents the current height of the pyramid being considered (or the side length of the current floor layer being added).
    let floor_area_for_full_pyramid = 0; // Total floor boxes used by the largest full pyramid built so far.
    let total_boxes_for_full_pyramid = 0; // Total boxes stored in the largest full pyramid built so far.

    // This loop finds the largest height 'h_val' such that a full "corner pyramid"
    // of that height can be built using 'n' or fewer boxes.
    // A corner pyramid of height H has H layers.
    // The k-th layer from the bottom (k=1 is the bottom-most layer) has k * (k+1) / 2 boxes.
    // The total number of boxes in a pyramid of height H is sum(k*(k+1)/2 for k=1 to H) = H*(H+1)*(H+2)/6 (Tetrahedral number).
    // The number of floor boxes (boxes in the bottom-most layer) for a pyramid of height H is sum(k for k=1 to H) = H*(H+1)/2 (Triangular number).

    while (true) {
        h_val++;

        // 'boxes_in_this_pyramid_slice' represents the number of boxes in the h_val-th layer (from the bottom)
        // if we were to build a pyramid of height h_val.
        // This is equivalent to the triangular number T(h_val) = h_val * (h_val + 1) / 2.
        // It's also the number of boxes that would be added to the total count if we extend the pyramid
        // to height 'h_val' by adding a new bottom layer.
        let boxes_in_this_pyramid_slice = floor_area_for_full_pyramid + h_val;

        // Check if adding this new layer (and making the pyramid height h_val) exceeds 'n'.
        if (total_boxes_for_full_pyramid + boxes_in_this_pyramid_slice <= n) {
            total_boxes_for_full_pyramid += boxes_in_this_pyramid_slice;
            floor_area_for_full_pyramid += h_val; // Add the 'h_val' boxes to the floor area.
        } else {
            break; // Cannot add this full layer, so the previous h_val was the max height.
        }
    }

    // After the loop, 'total_boxes_for_full_pyramid' holds the count of boxes in the largest
    // full corner pyramid that fits within 'n'.
    // 'floor_area_for_full_pyramid' holds the floor space used by this pyramid.

    let remaining_n = n - total_boxes_for_full_pyramid;
    let result_floor_area = floor_area_for_full_pyramid;

    // Now, we need to place the 'remaining_n' boxes.
    // The most efficient way to place additional boxes is to put them directly on the floor,
    // extending the base of the existing pyramid. Each such box occupies 1 unit of floor space.
    // We cannot efficiently stack them further without adding more supporting boxes to the floor,
    // which would essentially be extending the base anyway.
    result_floor_area += remaining_n;

    return result_floor_area;
};