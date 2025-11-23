#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<double> statsProbability(vector<int>& nums, int k) {
        map<int, double> dp;
        for (int num : nums) {
            dp[num] += 1.0 / nums.size();
        }

        for (int i = 1; i < k; ++i) {
            map<int, double> next_dp;
            for (auto& [sum, prob] : dp) {
                for (int num : nums) {
                    next_dp[sum + num] += prob * (1.0 / nums.size());
                }
            }
            dp = next_dp;
        }

        vector<double> result;
        for (auto& [sum, prob] : dp) {
            result.push_back(prob);
        }
        return result;
    }
};