var isRectangleCover = function(rectangles) {
    let minX = Infinity;
    let minY = Infinity;
    let maxX = -Infinity;
    let maxY = -Infinity;
    let totalArea = 0n; // Use BigInt for total area to handle large values

    const points = new Set(); // Stores unique corner points

    for (const rect of rectangles) {
        const x1 = rect[0];
        const y1 = rect[1];
        const x2 = rect[2];
        const y2 = rect[3];

        minX = Math.min(minX, x1);
        minY = Math.min(minY, y1);
        maxX = Math.max(maxX, x2);
        maxY = Math.max(maxY, y2);

        // Calculate individual rectangle area and add to total
        totalArea += BigInt(x2 - x1) * BigInt(y2 - y1);

        // Process corners: add to set if not present, remove if present
        // This ensures that only points touched an odd number of times remain in the set.
        const p1 = `${x1},${y1}`;
        const p2 = `${x1},${y2}`;
        const p3 = `${x2},${y1}`;
        const p4 = `${x2},${y2}`;

        [p1, p2, p3, p4].forEach(p => {
            if (points.has(p)) {
                points.delete(p);
            } else {
                points.add(p);
            }
        });
    }

    // Check 1: The set of remaining points must contain exactly the four corners of the perfect rectangle.
    // And these must be the overall min/max coordinates.
    const expectedCorners = [
        `${minX},${minY}`,
        `${minX},${maxY}`,
        `${maxX},${minY}`,
        `${maxX},${maxY}`
    ];

    if (points.size !== 4 || 
        !points.has(expectedCorners[0]) || 
        !points.has(expectedCorners[1]) || 
        !points.has(expectedCorners[2]) || 
        !points.has(expectedCorners[3])) {
        return false;
    }

    // Check 2: The sum of individual rectangle areas must equal the area of the bounding box.
    // This implicitly checks for overlaps (sum of areas would be too large) and gaps (sum of areas would be too small).
    const boundingBoxArea = BigInt(maxX - minX) * BigInt(maxY - minY);
    if (totalArea !== boundingBoxArea) {
        return false;
    }

    return true;
};