var rectangleArea = function(rectangles) {
    const MOD = 10**9 + 7;

    // Create events for the sweep line algorithm.
    // Each event represents a bottom or top edge of a rectangle.
    // Format: [y-coordinate, x1, x2, type]
    // type: 1 for a bottom edge (rectangle starts), -1 for a top edge (rectangle ends)
    const events = [];
    for (const [x1, y1, x2, y2] of rectangles) {
        // Only consider rectangles with positive area
        if (y1 < y2 && x1 < x2) {
            events.push([y1, x1, x2, 1]);  // Bottom edge event
            events.push([y2, x1, x2, -1]); // Top edge event
        }
    }

    // Sort events primarily by y-coordinate.
    // If y-coordinates are the same, the order of type (1 or -1) doesn't strictly matter
    // for this specific sweep line implementation because we calculate the area
    // based on the *previous* y-level before processing the current event.
    events.sort((a, b) => a[0] - b[0]);

    // xCoordsMap stores the net change in overlap count for each x-coordinate.
    // Key: x-coordinate, Value: net change (e.g., +1 for a rectangle starting at x, -1 for ending at x)
    const xCoordsMap = new Map();

    let totalArea = 0n; // Use BigInt to prevent overflow for large areas
    let prevY = events[0][0]; // Initialize prevY with the y-coordinate of the first event

    // Helper function to calculate the total length of active x-intervals
    // An x-interval is "active" if it's covered by at least one rectangle.
    const calculateActiveXLength = (map) => {
        let currentLength = 0n; // Use BigInt for currentLength
        let overlapCount = 0;   // Tracks how many rectangles currently cover the x-segment
        let prevX = null;       // Stores the previous x-coordinate encountered

        // Get all x-coordinates from the map keys and sort them.
        // This is necessary because JavaScript Map does not guarantee sorted iteration.
        const sortedX = Array.from(map.keys()).sort((a, b) => a - b);

        for (const x of sortedX) {
            if (prevX !== null) {
                // If overlapCount > 0, the segment [prevX, x] is covered by at least one rectangle
                if (overlapCount > 0) {
                    currentLength += BigInt(x - prevX);
                }
            }
            // Update overlapCount for the current x-coordinate
            overlapCount += map.get(x);
            prevX = x; // Move prevX to the current x
        }
        return currentLength;
    };

    // Iterate through all sorted events
    for (const [y, x1, x2, type] of events) {
        // Calculate the width of the current horizontal strip
        const xLength = calculateActiveXLength(xCoordsMap);
        // Calculate the height of the current horizontal strip
        const yDiff = BigInt(y - prevY);

        // Add the area of the current strip to the total area.
        // Ensure yDiff and xLength are positive to avoid adding zero or negative area.
        if (yDiff > 0n && xLength > 0n) {
            totalArea = (totalArea + (xLength * yDiff)) % BigInt(MOD);
        }

        // Update xCoordsMap based on the current event:
        // For a bottom edge (type=1), increment count at x1, decrement at x2.
        // For a top edge (type=-1), decrement count at x1, increment at x2.
        xCoordsMap.set(x1, (xCoordsMap.get(x1) || 0) + type);
        xCoordsMap.set(x2, (xCoordsMap.get(x2) || 0) - type);

        // Update prevY for the next strip calculation
        prevY = y;
    }

    // Convert the final BigInt totalArea back to a Number for the result
    return Number(totalArea);
};