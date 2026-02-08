int minHeightShelves(int** books, int booksSize, int* booksColSize, int shelfWidth) {
    int* dp = (int*)malloc((booksSize + 1) * sizeof(int));
    dp[0] = 0;

    for (int i = 1; i <= booksSize; i++) {
        int width = 0;
        int height = 0;
        dp[i] = INT_MAX;

        for (int j = i - 1; j >= 0; j--) {
            width += books[j][0];
            if (width > shelfWidth) break;

            if (books[j][1] > height) {
                height = books[j][1];
            }

            if (dp[j] + height < dp[i]) {
                dp[i] = dp[j] + height;
            }
        }
    }

    int result = dp[booksSize];
    free(dp);
    return result;
}