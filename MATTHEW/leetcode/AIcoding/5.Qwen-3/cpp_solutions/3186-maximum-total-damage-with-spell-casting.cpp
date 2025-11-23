#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumTotalDamage(vector<int>& power) {
        map<int, int> damageMap;
        for (int p : power) {
            damageMap[p]++;
        }

        vector<int> sortedPowers;
        for (auto& [p, _] : damageMap) {
            sortedPowers.push_back(p);
        }
        sort(sortedPowers.begin(), sortedPowers.end());

        int n = sortedPowers.size();
        vector<int> dp(n, 0);

        for (int i = 0; i < n; ++i) {
            int currentDamage = sortedPowers[i] * damageMap[sortedPowers[i]];
            dp[i] = currentDamage;

            for (int j = 0; j < i; ++j) {
                if (sortedPowers[i] - sortedPowers[j] > 1) {
                    dp[i] = max(dp[i], dp[j] + currentDamage);
                }
            }
        }

        return *max_element(dp.begin(), dp.end());
    }
};