#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int boxDelivering(vector<vector<int>>& boxes, int portsCount, int maxBoxes, int maxWeight) {
        int n = boxes.size();
        vector<long long> prefixWeight(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixWeight[i + 1] = prefixWeight[i] + boxes[i][1];
        }

        vector<int> dp(n + 1, 1e9);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            int weight = 0;
            int trips = 0;
            int boxesCount = 0;
            for (int j = i; j >= 1 && boxesCount < maxBoxes && weight + boxes[j - 1][1] <= maxWeight; --j) {
                weight += boxes[j - 1][1];
                boxesCount++;
                if (j == i || boxes[j - 1][0] != boxes[j][0]) {
                    trips++;
                }
                dp[i] = min(dp[i], dp[j - 1] + trips + 1);
            }
        }

        return dp[n];
    }
};