#include <vector>
#include <algorithm>

class Solution {
public:
    int minHeightShelves(std::vector<std::vector<int>>& books, int shelfWidth) {
        int n = books.size();
        std::vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            dp[i] = 1e9; // Initialize with a very large value

            int current_width = 0;
            int max_height_on_shelf = 0;

            // Try placing books from j to i-1 on the current shelf
            for (int j = i - 1; j >= 0; --j) {
                current_width += books[j][0];
                if (current_width > shelfWidth) {
                    break; // Cannot place more books on this shelf
                }
                max_height_on_shelf = std::max(max_height_on_shelf, books[j][1]);
                dp[i] = std::min(dp[i], dp[j] + max_height_on_shelf);
            }
        }

        return dp[n];
    }
};