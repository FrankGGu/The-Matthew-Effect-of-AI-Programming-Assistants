#include <vector>
#include <deque>
#include <algorithm>

class Solution {
public:
    long long minimumCoins(std::vector<int>& prices) {
        int n = prices.size();
        if (n == 0) {
            return 0;
        }

        // dp[i] stores the minimum cost to cover fruits from index 0 to i.
        std::vector<long long> dp(n);

        // Deque stores pairs of {cost, index_k}.
        // 'cost' represents (cost to cover fruits 0 to k-1) + prices[k].
        // This is the total cost if fruit 'k' is the last fruit bought to cover up to 2*k+1.
        // 'index_k' is the index of the fruit 'k' that was bought.
        std::deque<std::pair<long long, int>> dq;

        // Base case for dp[0]:
        // To cover fruit 0, we must buy fruit 0.
        // The cost to cover fruits 0 to -1 is 0. So, cost = 0 + prices[0].
        long long val_k0 = prices[0];
        dp[0] = val_k0;
        dq.push_back({val_k0, 0});

        for (int i = 1; i < n; ++i) {
            // Calculate the minimum index 'k' such that buying fruit 'k' can cover fruit 'i'.
            // A fruit 'k' covers fruit 'i' if k <= i and i <= 2*k + 1.
            // From i <= 2*k + 1, we derive (i - 1) / 2 <= k.
            // So, 'k' must be at least ceil((i-1)/2).
            // This can be computed as (i/2) if i is even, or (i-1)/2 if i is odd.
            int min_k_idx = (i % 2 == 0 ? i / 2 : (i - 1) / 2);

            // Remove elements from the front of the deque whose index 'k' is too small
            // to cover the current fruit 'i' (i.e., k < min_k_idx).
            while (!dq.empty() && dq.front().second < min_k_idx) {
                dq.pop_front();
            }

            // dp[i] is the minimum cost to cover fruits 0 to i.
            // Option 1: Fruit 'i' is covered by buying some fruit 'k' where k < i.
            // This 'k' must be in the range [min_k_idx, i-1].
            // The minimum cost for this option is stored at the front of the deque.
            dp[i] = dq.front().first;

            // Option 2: Fruit 'i' is covered by buying fruit 'i' itself.
            // The cost for this option is (cost to cover 0 to i-1) + prices[i].
            long long val_ki = dp[i-1] + prices[i];

            // Take the minimum of the two options.
            dp[i] = std::min(dp[i], val_ki);

            // Add the current fruit's cost (val_ki, representing cost if 'i' is the last fruit bought to cover 'i')
            // to the deque for future calculations.
            // Maintain the monotonic property (increasing indices, increasing costs) by
            // removing elements from the back that are more expensive than val_ki.
            while (!dq.empty() && dq.back().first >= val_ki) {
                dq.pop_back();
            }
            dq.push_back({val_ki, i});
        }

        // The minimum cost to buy all fruits (0 to n-1) is dp[n-1].
        return dp[n-1];
    }
};