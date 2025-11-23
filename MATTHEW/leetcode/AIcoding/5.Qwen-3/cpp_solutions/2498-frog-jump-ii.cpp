#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxDistance(vector<int>& stones) {
        unordered_map<int, int> dp;
        for (int i = 0; i < stones.size(); ++i) {
            for (int j = i - 1; j >= 0; --j) {
                int diff = stones[i] - stones[j];
                dp[diff] = max(dp[diff], dp[stones[i] - stones[j]] + 1);
            }
        }
        int result = 0;
        for (auto& [key, value] : dp) {
            result = max(result, key);
        }
        return result;
    }
};