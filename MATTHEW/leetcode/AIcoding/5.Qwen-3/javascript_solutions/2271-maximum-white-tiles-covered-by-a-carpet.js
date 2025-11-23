function maximumWhiteTiles(tiles, carpetLen) {
    tiles.sort((a, b) => a[0] - b[0]);
    let max = 0;
    let i = 0;
    let covered = 0;
    let start = 0;

    for (let end = 0; end < tiles.length; end++) {
        const [tileStart, tileEnd] = tiles[end];
        while (start + carpetLen > tileStart) {
            if (start + carpetLen >= tileEnd) {
                covered += tileEnd - tileStart;
                start = tileEnd;
            } else {
                covered += start + carpetLen - tileStart;
                start += carpetLen;
            }
            if (start >= tileEnd) {
                i++;
            }
        }
        max = Math.max(max, covered);
    }

    return max;
}