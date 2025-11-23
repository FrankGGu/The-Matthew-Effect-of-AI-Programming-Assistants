var minHeightShelves = function(books, shelfWidth) {
    const n = books.length;
    const dp = Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        let width = 0;
        let height = 0;
        dp[i] = Infinity;

        for (let j = i; j > 0; j--) {
            width += books[j - 1][0];
            if (width > shelfWidth) break;
            height = Math.max(height, books[j - 1][1]);
            dp[i] = Math.min(dp[i], dp[j - 1] + height);
        }
    }

    return dp[n];
};