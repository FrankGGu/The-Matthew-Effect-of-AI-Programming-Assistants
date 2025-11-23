#include <vector>
#include <algorithm>

using namespace std;

long long minCostToEqualizeArray(vector<int>& nums, vector<int>& cost) {
    vector<pair<int, int>> pairs;
    for (int i = 0; i < nums.size(); ++i) {
        pairs.push_back({nums[i], cost[i]});
    }
    sort(pairs.begin(), pairs.end());

    vector<long long> prefixSum(cost.size() + 1, 0);
    for (int i = 0; i < cost.size(); ++i) {
        prefixSum[i + 1] = prefixSum[i] + pairs[i].second;
    }

    long long bestCost = -1;
    for (int i = 0; i < nums.size(); ++i) {
        long long currentCost = 0;
        for (int j = 0; j < nums.size(); ++j) {
            currentCost += (long long)abs(nums[j] - nums[i]) * cost[j];
        }

        if (bestCost == -1 || currentCost < bestCost) {
            bestCost = currentCost;
        }
    }

    long long low = pairs[0].first;
    long long high = pairs.back().first;

    while (low < high) {
        long long mid1 = low + (high - low) / 3;
        long long mid2 = high - (high - low) / 3;

        long long cost1 = 0;
        for (int i = 0; i < nums.size(); ++i) {
            cost1 += (long long)abs(nums[i] - mid1) * cost[i];
        }

        long long cost2 = 0;
        for (int i = 0; i < nums.size(); ++i) {
            cost2 += (long long)abs(nums[i] - mid2) * cost[i];
        }

        if (cost1 < cost2) {
            high = mid2 - 1;
        } else {
            low = mid1 + 1;
        }
    }

    if (bestCost == -1) bestCost = LLONG_MAX;
    long long finalCost = 0;
    for (int i = 0; i < nums.size(); ++i) {
        finalCost += (long long)abs(nums[i] - low) * cost[i];
    }

    return min(bestCost, finalCost);
}