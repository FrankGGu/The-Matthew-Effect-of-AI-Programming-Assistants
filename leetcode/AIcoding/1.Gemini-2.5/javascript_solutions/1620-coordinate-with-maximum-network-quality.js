var bestCoordinate = function(towers, radius) {
    let maxQuality = 0;
    let bestCoord = [0, 0];

    // Determine the search range for x and y coordinates.
    // Towers are located within [0, 50] for both x and y.
    // A point (x, y) can be up to 'radius' distance away from any tower.
    // So, the relevant search space for x and y is [min_tower_coord - radius, max_tower_coord + radius].
    // Given 0 <= xi, yi <= 50, this means the search range is [0 - radius, 50 + radius].
    const searchMinX = 0 - radius;
    const searchMaxX = 50 + radius;
    const searchMinY = 0 - radius;
    const searchMaxY = 50 + radius;

    for (let x = searchMinX; x <= searchMaxX; x++) {
        for (let y = searchMinY; y <= searchMaxY; y++) {
            let currentQuality = 0;

            for (const tower of towers) {
                const tx = tower[0];
                const ty = tower[1];
                const tq = tower[2];

                const distSq = (x - tx) * (x - tx) + (y - ty) * (y - ty);
                const dist = Math.sqrt(distSq);

                if (dist <= radius) {
                    currentQuality += Math.floor(tq / (1 + dist));
                }
            }

            // Update best coordinate based on quality and lexicographical order
            if (currentQuality > maxQuality) {
                maxQuality = currentQuality;
                bestCoord = [x, y];
            } else if (currentQuality === maxQuality) {
                // Lexicographical comparison: smallest x, then smallest y
                if (x < bestCoord[0]) {
                    bestCoord = [x, y];
                } else if (x === bestCoord[0] && y < bestCoord[1]) {
                    bestCoord = [x, y];
                }
            }
        }
    }

    return bestCoord;
};