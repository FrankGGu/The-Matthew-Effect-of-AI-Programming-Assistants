var maximumWhiteTiles = function(tiles, carpetLen) {
    tiles.sort((a, b) => a[0] - b[0]);
    let maxCover = 0;
    let left = 0;
    let currentCover = 0;
    let n = tiles.length;

    for (let right = 0; right < n; right++) {
        let start = tiles[right][0];
        let end = tiles[right][1];

        currentCover += end - start + 1;

        while (tiles[left][1] < start + carpetLen - 1) {
            let gap = start + carpetLen - 1 - tiles[left][1];
            if (gap > 0) {
                currentCover -= tiles[left][1] - tiles[left][0] + 1;
                left++;
            } else {
                break;
            }
        }

        let partial = 0;
        if (tiles[left][0] <= start + carpetLen - 1) {
            partial = start + carpetLen - 1 - tiles[left][0] + 1;
        }

        maxCover = Math.max(maxCover, currentCover - (end - start + 1) + partial);
    }

    return maxCover;
};