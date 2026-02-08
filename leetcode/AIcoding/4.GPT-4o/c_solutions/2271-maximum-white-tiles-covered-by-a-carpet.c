int maximumWhiteTiles(int** tiles, int tilesSize, int* tilesColSize, int carpetLen) {
    int maxWhiteTiles = 0, currentWhiteTiles = 0;
    int covered[10001] = {0};

    for (int i = 0; i < tilesSize; i++) {
        covered[tiles[i][0]] += tiles[i][1] - tiles[i][0] + 1;
    }

    for (int i = 1; i < 10001; i++) {
        covered[i] += covered[i - 1];
    }

    for (int left = 0, right = 0; right < 10001; right++) {
        while (right - left + 1 > carpetLen) {
            left++;
        }
        maxWhiteTiles = max(maxWhiteTiles, covered[right] - (left > 0 ? covered[left - 1] : 0));
    }

    return maxWhiteTiles;
}