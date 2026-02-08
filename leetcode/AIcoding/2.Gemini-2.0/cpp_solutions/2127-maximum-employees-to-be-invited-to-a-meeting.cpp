#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumInvitations(vector<int>& favorite) {
        int n = favorite.size();
        vector<int> inDegree(n, 0);
        for (int i = 0; i < n; ++i) {
            inDegree[favorite[i]]++;
        }

        vector<int> dp(n, 1);
        vector<bool> visited(n, false);
        vector<int> q;

        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push_back(i);
            }
        }

        int head = 0;
        while (head < q.size()) {
            int u = q[head++];
            visited[u] = true;
            int v = favorite[u];
            dp[v] = max(dp[v], dp[u] + 1);
            inDegree[v]--;
            if (inDegree[v] == 0) {
                q.push_back(v);
            }
        }

        int ringSum = 0;
        int chainSum = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                int j = i;
                int count = 0;
                while (!visited[j]) {
                    visited[j] = true;
                    j = favorite[j];
                    count++;
                }
                ringSum += count;
            }
        }

        for (int i = 0; i < n; ++i) {
            if (favorite[favorite[i]] == i) {
                chainSum += dp[i] + dp[favorite[i]];
                dp[i] = dp[favorite[i]] = 0;
            }
        }

        return max(ringSum, chainSum / 2);
    }
};