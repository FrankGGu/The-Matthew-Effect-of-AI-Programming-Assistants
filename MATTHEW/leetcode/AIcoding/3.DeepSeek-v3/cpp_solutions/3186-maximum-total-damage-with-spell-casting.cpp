#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long maximumTotalDamage(vector<int>& power) {
        unordered_map<int, int> freq;
        for (int p : power) {
            freq[p]++;
        }

        vector<int> uniquePowers;
        for (auto& entry : freq) {
            uniquePowers.push_back(entry.first);
        }
        sort(uniquePowers.begin(), uniquePowers.end());

        int n = uniquePowers.size();
        vector<long long> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            int currentPower = uniquePowers[i - 1];
            long long total = (long long)currentPower * freq[currentPower];

            int j = i - 1;
            while (j >= 1 && uniquePowers[j - 1] >= currentPower - 2) {
                j--;
            }

            dp[i] = max(dp[i - 1], total + (j >= 1 ? dp[j] : 0));
        }

        return dp[n];
    }
};