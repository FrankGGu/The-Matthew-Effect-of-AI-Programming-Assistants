var findMinArrowShots = function(points) {
    if (points.length === 0) {
        return 0;
    }

    // Sort the balloons by their end points.
    // If end points are the same, the order of start points doesn't affect correctness
    // but a consistent sort (e.g., by start point) is good practice.
    points.sort((a, b) => a[1] - b[1]);

    let arrows = 1;
    let currentArrowEnd = points[0][1];

    for (let i = 1; i < points.length; i++) {
        const [balloonStart, balloonEnd] = points[i];

        // If the current balloon's start is after the current arrow's end point,
        // it means this balloon cannot be burst by the current arrow.
        // We need a new arrow.
        if (balloonStart > currentArrowEnd) {
            arrows++;
            currentArrowEnd = balloonEnd; // Set the new arrow's end to this balloon's end
        } else {
            // This balloon overlaps or touches the current arrow's range.
            // It can be burst by the same arrow.
            // To maximize future overlaps, the arrow must be shot within the intersection
            // of all balloons burst by this arrow. The effective end point for this
            // arrow's range becomes the minimum of the current arrow's end and this balloon's end.
            currentArrowEnd = Math.min(currentArrowEnd, balloonEnd);
        }
    }

    return arrows;
};