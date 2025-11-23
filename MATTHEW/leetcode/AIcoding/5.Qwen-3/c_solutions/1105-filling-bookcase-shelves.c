#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minHeightShelves(int** books, int booksSize, int* booksColSize, int shelfWidth) {
    int* dp = (int*)malloc((booksSize + 1) * sizeof(int));
    dp[0] = 0;

    for (int i = 1; i <= booksSize; ++i) {
        dp[i] = INT_MAX;
        int currentHeight = 0;
        int currentWidth = 0;

        for (int j = i - 1; j >= 0; --j) {
            currentWidth += books[j][0];
            if (currentWidth > shelfWidth) break;
            currentHeight = (currentHeight > books[j][1]) ? currentHeight : books[j][1];
            dp[i] = (dp[i] < dp[j] + currentHeight) ? dp[i] : dp[j] + currentHeight;
        }
    }

    int result = dp[booksSize];
    free(dp);
    return result;
}