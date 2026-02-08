var minHeightShelves = function(books, shelfWidth) {
    const n = books.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        let currentWidth = 0;
        let currentHeight = 0;
        for (let j = i - 1; j >= 0; j--) {
            currentWidth += books[j][0];
            if (currentWidth > shelfWidth) {
                break;
            }
            currentHeight = Math.max(currentHeight, books[j][1]);
            dp[i] = Math.min(dp[i], dp[j] + currentHeight);
        }
    }

    return dp[n];
};