var maximumWhiteTiles = function(tiles, carpetLen) {
    let maxTilesCovered = 0;
    let currentTilesSum = 0;
    let j = 0; // Left pointer for the sliding window

    for (let i = 0; i < tiles.length; i++) {
        // Add the full length of the current tile to the sum
        currentTilesSum += (tiles[i][1] - tiles[i][0] + 1);

        // Calculate the potential left edge of the carpet if its right edge is at tiles[i][1]
        let carpetStart = tiles[i][1] - carpetLen + 1;

        // Shrink the window from the left (j) if tiles[j] is completely outside the carpet
        while (tiles[j][1] < carpetStart) {
            currentTilesSum -= (tiles[j][1] - tiles[j][0] + 1);
            j++;
        }

        // At this point, tiles[j] is the first tile that potentially overlaps with the carpet.
        // The carpet covers from `carpetStart` to `tiles[i][1]`.
        // `currentTilesSum` includes the full length of tiles from `tiles[j]` to `tiles[i]`.
        // We need to subtract the part of `tiles[j]` that is to the left of `carpetStart`.
        let coveredByCurrentCarpet = currentTilesSum;
        if (tiles[j][0] < carpetStart) {
            coveredByCurrentCarpet -= (carpetStart - tiles[j][0]);
        }

        maxTilesCovered = Math.max(maxTilesCovered, coveredByCurrentCarpet);
    }

    return maxTilesCovered;
};