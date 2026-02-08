#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minHeightShelves(int** books, int booksSize, int* booksColSize, int shelfWidth) {
    int* dp = (int*)malloc((booksSize + 1) * sizeof(int));
    dp[0] = 0;

    for (int i = 1; i <= booksSize; i++) {
        dp[i] = INT_MAX;
        int width = 0;
        int height = 0;
        for (int j = i; j >= 1; j--) {
            width += books[j - 1][0];
            if (width > shelfWidth) {
                break;
            }
            height = height > books[j - 1][1] ? height : books[j - 1][1];
            if (dp[j - 1] != INT_MAX && dp[j - 1] + height < dp[i]) {
                dp[i] = dp[j - 1] + height;
            }
        }
    }

    int result = dp[booksSize];
    free(dp);
    return result;
}