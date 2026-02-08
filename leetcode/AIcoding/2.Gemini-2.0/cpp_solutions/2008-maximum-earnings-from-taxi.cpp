#include <vector>
#include <algorithm>

using namespace std;

long long maxTaxiEarnings(int n, vector<vector<int>>& rides) {
    vector<vector<pair<int, int>>> adj(n + 1);
    for (auto& ride : rides) {
        adj[ride[0]].push_back({ride[1], ride[2] + ride[1] - ride[0]});
    }

    vector<long long> dp(n + 1, 0);
    for (int i = 1; i <= n; ++i) {
        dp[i] = dp[i - 1];
        for (auto& ride : adj[i]) {
            dp[ride.first] = max(dp[ride.first], dp[i - 1] + ride.second);
        }
    }

    return dp[n];
}