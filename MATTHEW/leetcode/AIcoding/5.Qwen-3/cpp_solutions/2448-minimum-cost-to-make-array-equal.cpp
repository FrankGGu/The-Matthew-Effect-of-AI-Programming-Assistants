#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minCostToMakeArrayEqual(vector<int>& nums, vector<int>& cost) {
        vector<pair<int, int>> pairs;
        for (int i = 0; i < nums.size(); ++i) {
            pairs.push_back({nums[i], cost[i]});
        }

        sort(pairs.begin(), pairs.end());

        long long totalCost = 0;
        long long leftSum = 0;
        long long rightSum = 0;

        for (int i = 1; i < pairs.size(); ++i) {
            rightSum += static_cast<long long>(pairs[i].second) * (pairs[i].first - pairs[0].first);
        }

        totalCost = rightSum;

        for (int i = 1; i < pairs.size(); ++i) {
            leftSum += static_cast<long long>(pairs[i].second) * (pairs[i].first - pairs[i - 1].first);
            rightSum -= static_cast<long long>(pairs[i].second) * (pairs[i].first - pairs[i - 1].first);
            totalCost = min(totalCost, leftSum + rightSum);
        }

        return totalCost;
    }
};