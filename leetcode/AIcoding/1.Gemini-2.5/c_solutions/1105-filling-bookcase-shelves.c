#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int minHeightShelves(int** books, int booksSize, int* booksColSize, int shelfWidth) {
    int n = booksSize;
    int dp[n + 1];

    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        dp[i] = INT_MAX;
    }

    for (int i = 1; i <= n; i++) {
        int current_width = 0;
        int max_height_on_shelf = 0;

        for (int j = i - 1; j >= 0; j--) {
            current_width += books[j][0];
            max_height_on_shelf = max(max_height_on_shelf, books[j][1]);

            if (current_width <= shelfWidth) {
                dp[i] = min(dp[i], dp[j] + max_height_on_shelf);
            } else {
                break;
            }
        }
    }

    return dp[n];
}