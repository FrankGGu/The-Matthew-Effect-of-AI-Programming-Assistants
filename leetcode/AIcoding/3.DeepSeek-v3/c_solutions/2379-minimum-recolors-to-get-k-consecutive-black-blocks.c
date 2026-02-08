int minimumRecolors(char* blocks, int k) {
    int n = strlen(blocks);
    int whiteCount = 0;
    int minRecolors = n;

    for (int i = 0; i < n; i++) {
        if (blocks[i] == 'W') {
            whiteCount++;
        }

        if (i >= k - 1) {
            if (whiteCount < minRecolors) {
                minRecolors = whiteCount;
            }

            if (blocks[i - k + 1] == 'W') {
                whiteCount--;
            }
        }
    }

    return minRecolors;
}