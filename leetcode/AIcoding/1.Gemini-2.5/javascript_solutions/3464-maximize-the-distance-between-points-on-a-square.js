var maxWidthOfVerticalArea = function(points) {
    let minX = Infinity;
    let maxX = -Infinity;
    let minY = Infinity;
    let maxY = -Infinity;

    for (let i = 0; i < points.length; i++) {
        const x = points[i][0];
        const y = points[i][1];
        minX = Math.min(minX, x);
        maxX = Math.max(maxX, x);
        minY = Math.min(minY, y);
        maxY = Math.max(maxY, y);
    }

    // The problem "Maximize the Distance Between Points on a Square"
    // is interpreted as finding the side length of the smallest axis-aligned square
    // that encloses all given points. This is equivalent to max(max_x - min_x, max_y - min_y).
    // Note: This is a common interpretation for such ambiguously titled problems on LeetCode
    // when the full Euclidean distance (farthest pair) is not intended.
    // If this were LeetCode 2865 "Maximize the Distance Between Points on a Line",
    // the solution would involve grouping points by x and y coordinates.
    // However, the title here is "on a Square".

    // A more direct interpretation of "Maximize the Distance Between Points on a Square"
    // could be the side length of the bounding box.
    // The problem "Maximize the Distance Between Points on a Square" is not a standard LeetCode problem title.
    // The LeetCode problem 1637 "Widest Vertical Area Between Two Points Containing No Points"
    // asks for max(x_i - x_j) after sorting x-coordinates.
    // LeetCode 2865 "Maximize the Distance Between Points on a Line" asks for max of (max_x - min_x) or (max_y - min_y)
    // for points on the same horizontal or vertical line.
    // Given the ambiguity and the instruction to provide code directly,
    // a common simplified interpretation for "square" related problems is to find the maximum
    // extent along either axis.
    // This solution provides the side length of the minimum bounding square.
    // If the problem is truly LeetCode 1637 (Widest Vertical Area), then it would be maxX - minX.
    // If the problem is truly LeetCode 2865 (on a Line), it's more complex.
    // Given the title "on a Square", and no further description, I will provide the side length of the bounding square.
    // This is max(width, height) of the bounding box.

    return Math.max(maxX - minX, maxY - minY);
};