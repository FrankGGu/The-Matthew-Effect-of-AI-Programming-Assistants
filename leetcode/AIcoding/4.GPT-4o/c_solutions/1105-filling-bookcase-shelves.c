int minHeightShelves(int** books, int booksSize, int* booksColSize, int shelfWidth) {
    int* dp = (int*)malloc((booksSize + 1) * sizeof(int));
    for (int i = 0; i <= booksSize; i++) {
        dp[i] = 0x3f3f3f3f;
    }
    dp[0] = 0;

    for (int i = 1; i <= booksSize; i++) {
        int width = 0, maxHeight = 0;
        for (int j = i - 1; j >= 0; j--) {
            width += books[j][0];
            if (width > shelfWidth) break;
            maxHeight = fmax(maxHeight, books[j][1]);
            dp[i] = fmin(dp[i], dp[j] + maxHeight);
        }
    }

    int result = dp[booksSize];
    free(dp);
    return result;
}