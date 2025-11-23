#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int maxHeight(std::vector<std::vector<int>>& cuboids) {
        // Step 1: Normalize each cuboid by sorting its dimensions (l, w, h)
        // This ensures that for any cuboid, its dimensions are ordered (smallest, middle, largest).
        // This allows us to freely rotate cuboids and only compare corresponding dimensions.
        for (auto& cuboid : cuboids) {
            std::sort(cuboid.begin(), cuboid.end());
        }

        // Step 2: Sort the entire list of cuboids.
        // The sorting criteria are crucial for the dynamic programming approach.
        // We sort in descending order based on the smallest dimension, then middle, then largest.
        // This ensures that if cuboid 'a' can be a base for cuboid 'b' (i.e., 'a' is larger than 'b' in all dimensions),
        // 'a' will likely appear before 'b' in the sorted list.
        std::sort(cuboids.begin(), cuboids.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[0] != b[0]) return a[0] > b[0]; // Sort by smallest dimension descending
            if (a[1] != b[1]) return a[1] > b[1]; // Then by middle dimension descending
            return a[2] > b[2]; // Then by largest dimension descending
        });

        // Step 3: Dynamic Programming to find the maximum height.
        // dp[i] will store the maximum height achievable when cuboids[i] is the topmost cuboid in a stack.
        int n = cuboids.size();
        std::vector<int> dp(n);
        int max_total_height = 0;

        for (int i = 0; i < n; ++i) {
            // Initialize dp[i] with the height of the current cuboid itself.
            // cuboids[i][2] is the largest dimension, which will be its height if it's the only cuboid.
            dp[i] = cuboids[i][2];

            // Iterate through all cuboids processed before cuboids[i] (j < i).
            // Try to place cuboids[i] on top of cuboids[j].
            for (int j = 0; j < i; ++j) {
                // Check if cuboids[i] can be placed on top of cuboids[j].
                // This condition means that all dimensions of cuboids[i] must be less than or equal to
                // the corresponding dimensions of cuboids[j].
                if (cuboids[i][0] <= cuboids[j][0] &&
                    cuboids[i][1] <= cuboids[j][1] &&
                    cuboids[i][2] <= cuboids[j][2]) {
                    // If it can be placed, update dp[i] to the maximum height achieved by
                    // stacking cuboids[i] on top of the stack ending at cuboids[j].
                    dp[i] = std::max(dp[i], dp[j] + cuboids[i][2]);
                }
            }
            // Update the overall maximum height found so far.
            max_total_height = std::max(max_total_height, dp[i]);
        }

        return max_total_height;
    }
};