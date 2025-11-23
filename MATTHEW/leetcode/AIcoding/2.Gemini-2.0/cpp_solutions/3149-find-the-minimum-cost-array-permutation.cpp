#include <vector>
#include <algorithm>

using namespace std;

long long minCost(vector<int>& nums, vector<int>& cost) {
    int n = nums.size();
    vector<pair<int, int>> arr(n);
    for (int i = 0; i < n; ++i) {
        arr[i] = {nums[i], cost[i]};
    }
    sort(arr.begin(), arr.end());

    vector<int> sortedNums(n);
    vector<int> sortedCost(n);
    for (int i = 0; i < n; ++i) {
        sortedNums[i] = arr[i].first;
        sortedCost[i] = arr[i].second;
    }

    long long totalCost = 0;
    long long sum = 0;
    for (int i = 0; i < n; ++i) {
        totalCost += (long long)sortedNums[i] * sum;
        sum += sortedCost[i];
    }

    return totalCost;
}