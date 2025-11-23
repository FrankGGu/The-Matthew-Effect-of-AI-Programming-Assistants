class Solution {
    public int minHeightShelves(int[][] books, int shelfWidth) {
        int n = books.length;
        int[] dp = new int[n + 1];

        // dp[0] = 0, representing no books placed, thus 0 height.

        for (int i = 1; i <= n; i++) {
            // Initialize dp[i] to a very large value, as we are looking for the minimum height.
            dp[i] = Integer.MAX_VALUE;

            int currentWidth = 0;
            int maxHeightOnShelf = 0;

            // Iterate backwards from the current book (books[i-1]) to find all possible
            // groupings for the last shelf.
            for (int j = i - 1; j >= 0; j--) {
                int bookWidth = books[j][0];
                int bookHeight = books[j][1];

                currentWidth += bookWidth;

                // If adding the current book exceeds the shelf width,
                // then no more books can be added to this shelf.
                if (currentWidth > shelfWidth) {
                    break;
                }

                // Update the maximum height on the current shelf.
                maxHeightOnShelf = Math.max(maxHeightOnShelf, bookHeight);

                // Calculate the total height if books from index j to i-1 are placed
                // on the current shelf. This height would be the minimum height to place
                // books before index j (dp[j]) plus the height of the current shelf.
                dp[i] = Math.min(dp[i], dp[j] + maxHeightOnShelf);
            }
        }

        // dp[n] will contain the minimum height to place all 'n' books.
        return dp[n];
    }
}