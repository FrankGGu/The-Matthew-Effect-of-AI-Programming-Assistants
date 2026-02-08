var maxPoints = function(points) {
    if (points.length <= 2) {
        return points.length;
    }

    let maxOverallPoints = 0;

    // Helper function for Greatest Common Divisor (Euclidean algorithm)
    function gcd(a, b) {
        a = Math.abs(a);
        b = Math.abs(b);
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    for (let i = 0; i < points.length; i++) {
        let p1 = points[i];
        let x1 = p1[0];
        let y1 = p1[1];

        let slopeCounts = new Map(); // Stores counts of points for each slope originating from p1
        let verticalPoints = 0;     // Count of points forming a vertical line with p1
        let overlapPoints = 0;      // Count of points identical to p1
        let currentMaxPointsThroughP1 = 0; // Max distinct points on a line through p1 (excluding overlaps)

        for (let j = i + 1; j < points.length; j++) {
            let p2 = points[j];
            let x2 = p2[0];
            let y2 = p2[1];

            // Handle identical points
            if (x1 === x2 && y1 === y2) {
                overlapPoints++;
                continue; 
            }

            // Calculate delta x and delta y
            let dx = x2 - x1;
            let dy = y2 - y1;

            if (dx === 0) { // Vertical line
                verticalPoints++;
            } else {
                // Normalize the slope (dy/dx) to ensure unique keys for identical slopes.
                // A common normalization is to ensure dy is non-negative. 
                // If dy is 0, ensure dx is positive. This handles cases like (1/1) and (-1/-1)
                // resulting in the same normalized key.
                if (dy < 0 || (dy === 0 && dx < 0)) {
                    dx = -dx;
                    dy = -dy;
                }

                let commonDivisor = gcd(dx, dy);
                let simplifiedDx = dx / commonDivisor;
                let simplifiedDy = dy / commonDivisor;

                // Use a string as a key for the map: "dy/dx"
                let slopeKey = `${simplifiedDy}/${simplifiedDx}`;

                slopeCounts.set(slopeKey, (slopeCounts.get(slopeKey) || 0) + 1);
                currentMaxPointsThroughP1 = Math.max(currentMaxPointsThroughP1, slopeCounts.get(slopeKey));
            }
        }

        // Update currentMaxPointsThroughP1 with vertical points count
        currentMaxPointsThroughP1 = Math.max(currentMaxPointsThroughP1, verticalPoints);

        // The total points on the line (including p1 itself and its duplicates)
        // is currentMaxPointsThroughP1 (distinct points) + overlapPoints + 1 (for p1)
        maxOverallPoints = Math.max(maxOverallPoints, currentMaxPointsThroughP1 + overlapPoints + 1);
    }

    return maxOverallPoints;
};