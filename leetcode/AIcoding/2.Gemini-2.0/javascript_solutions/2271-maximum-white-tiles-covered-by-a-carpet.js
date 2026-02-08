var maximumWhiteTiles = function(tiles, carpetLen) {
    tiles.sort((a, b) => a[0] - b[0]);
    let n = tiles.length;
    let prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + (tiles[i][1] - tiles[i][0] + 1);
    }

    let maxCover = 0;
    for (let i = 0; i < n; i++) {
        let start = tiles[i][0];
        let end = start + carpetLen - 1;
        let left = i;
        let right = n - 1;
        let index = -1;
        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            if (tiles[mid][0] <= end) {
                index = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        let covered = prefixSum[index + 1] - prefixSum[i];
        if (index < n && tiles[index][1] > end) {
            covered += end - tiles[index][0] + 1;
        }

        maxCover = Math.max(maxCover, covered);
    }

    return maxCover;
};