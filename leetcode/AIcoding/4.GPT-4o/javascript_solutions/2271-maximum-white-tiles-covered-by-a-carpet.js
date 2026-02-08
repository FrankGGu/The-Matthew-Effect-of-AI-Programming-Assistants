var maximumWhiteTiles = function(tiles, carpetLen) {
    tiles.sort((a, b) => a[0] - b[0]);
    let maxCovered = 0, currentCovered = 0, start = 0, end = 0, n = tiles.length;

    while (end < n) {
        let tileStart = tiles[end][0], tileEnd = tiles[end][1];
        let coverWithCarpet = Math.min(carpetLen, tileEnd - tileStart + 1);
        currentCovered += coverWithCarpet;

        while (carpetLen < (tileEnd - tileStart + 1) + (end > 0 ? tiles[end - 1][0] - tiles[start][0] : 0)) {
            currentCovered -= Math.min(tiles[start][1] - tiles[start][0] + 1, carpetLen);
            start++;
        }

        maxCovered = Math.max(maxCovered, currentCovered);
        end++;
    }

    return maxCovered;
};