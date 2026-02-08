int cmp(const void* a, const void* b) {
    return (*(int**)a)[0] - (*(int**)b)[0];
}

int maximumWhiteTiles(int** tiles, int tilesSize, int* tilesColSize, int carpetLen) {
    qsort(tiles, tilesSize, sizeof(int*), cmp);

    int left = 0;
    int right = 0;
    int maxCover = 0;
    int currentCover = 0;

    while (right < tilesSize && maxCover < carpetLen) {
        int start = tiles[left][0];
        int end = start + carpetLen - 1;

        if (tiles[right][1] <= end) {
            currentCover += tiles[right][1] - tiles[right][0] + 1;
            right++;
            maxCover = (currentCover > maxCover) ? currentCover : maxCover;
        } else {
            if (end >= tiles[right][0]) {
                maxCover = (maxCover > currentCover + end - tiles[right][0] + 1) ? maxCover : currentCover + end - tiles[right][0] + 1;
            }
            currentCover -= tiles[left][1] - tiles[left][0] + 1;
            left++;
        }
    }

    return maxCover;
}