var isRectangleOverlap = function(rec1, rec2) {
    // Check for overlap on x-axis
    // rec1's left edge must be to the left of rec2's right edge
    // AND rec2's left edge must be to the left of rec1's right edge
    const xOverlap = rec1[0] < rec2[2] && rec2[0] < rec1[2];

    // Check for overlap on y-axis
    // rec1's bottom edge must be below rec2's top edge
    // AND rec2's bottom edge must be below rec1's top edge
    const yOverlap = rec1[1] < rec2[3] && rec2[1] < rec1[3];

    // Rectangles overlap if and only if they overlap on both x and y axes
    return xOverlap && yOverlap;
};