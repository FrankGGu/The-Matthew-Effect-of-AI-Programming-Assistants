#include <vector>
#include <numeric>
#include <algorithm>
#include <limits> // Required for std::numeric_limits

class Solution {
public:
    int minimumTime(std::vector<int>& nums1, std::vector<int>& nums2, int x) {
        int n = nums1.size();
        std::vector<std::pair<int, int>> items(n);
        for (int i = 0; i < n; ++i) {
            items[i] = {nums1[i], nums2[i]};
        }

        // Sort items by nums2[i] in ascending order.
        // This sorting order is crucial for the DP state transition logic,
        // as it helps ensure that when making choices for dp[j], we are considering
        // items in an order that prioritizes smaller nums2 values, which are
        // multiplied by 'k' later.
        std::sort(items.begin(), items.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            return a.second < b.second;
        });

        // dp[j] stores the maximum sum of nums1 values for j items chosen.
        // sum2_val[j] stores the corresponding sum of nums2 values for the j items that yield dp[j].
        // If multiple sets of j items yield the same maximum sum1, we choose the one with the minimum sum2.
        std::vector<long long> dp(n + 1, std::numeric_limits<long long>::min());
        std::vector<long long> sum2_val(n + 1, std::numeric_limits<long long>::max());

        // Base case: 0 items chosen, sum1 = 0, sum2 = 0.
        dp[0] = 0;
        sum2_val[0] = 0;

        // Iterate through each item to build up the DP table
        for (const auto& item : items) {
            int n1 = item.first;
            int n2 = item.second;

            // Iterate j from n down to 1 (to simulate 0/1 knapsack, ensuring each item is used at most once)
            for (int j = n; j >= 1; --j) {
                // If j-1 items are reachable (i.e., dp[j-1] is not its initial sentinel value)
                if (dp[j - 1] != std::numeric_limits<long long>::min()) {
                    long long current_sum1 = dp[j - 1] + n1;
                    long long current_sum2 = sum2_val[j - 1] + n2;

                    // If we found a better sum1 for j items
                    if (current_sum1 > dp[j]) {
                        dp[j] = current_sum1;
                        sum2_val[j] = current_sum2;
                    } 
                    // If sum1 is the same, choose the one with a smaller sum2
                    // because a smaller sum2 will result in a smaller total sum (sum1 + k*sum2)
                    else if (current_sum1 == dp[j]) {
                        sum2_val[j] = std::min(sum2_val[j], current_sum2);
                    }
                }
            }
        }

        // After filling the DP table, iterate through possible number of items kept (j) from n down to 0.
        // This corresponds to iterating k (time, number of items removed) from 0 to n.
        // We want the minimum k, so the first k (corresponding to largest j) that satisfies the condition is the answer.
        for (int j = n; j >= 0; --j) {
            if (dp[j] != std::numeric_limits<long long>::min()) {
                long long k = n - j; // k is the number of items removed, which is also the time elapsed
                long long current_total_sum = dp[j] + k * sum2_val[j];

                if (current_total_sum <= x) {
                    return k;
                }
            }
        }

        // This line should theoretically not be reached given x >= 1.
        // If x >= 0, keeping 0 items (k=n) always results in a sum of 0, which is <= x.
        return n; 
    }
};