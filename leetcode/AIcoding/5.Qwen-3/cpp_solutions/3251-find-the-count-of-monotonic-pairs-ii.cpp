#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countMonotonicPairs(int n, vector<int>& nums) {
        unordered_map<int, int> dp;
        int result = 0;
        for (int i = 0; i < n; ++i) {
            int count = 0;
            for (int j = 0; j <= nums[i]; ++j) {
                count += dp[j];
            }
            result += count;
            dp[nums[i]] += 1;
        }
        return result;
    }
};