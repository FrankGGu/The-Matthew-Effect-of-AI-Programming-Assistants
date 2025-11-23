int minimumRecolors(char *blocks, int k) {
    int n = strlen(blocks);
    int minRecolors = k;
    int currentRecolors = 0;

    for (int i = 0; i < k; i++) {
        if (blocks[i] == 'W') currentRecolors++;
    }
    minRecolors = currentRecolors;

    for (int i = k; i < n; i++) {
        if (blocks[i] == 'W') currentRecolors++;
        if (blocks[i - k] == 'W') currentRecolors--;
        minRecolors = fmin(minRecolors, currentRecolors);
    }

    return minRecolors;
}