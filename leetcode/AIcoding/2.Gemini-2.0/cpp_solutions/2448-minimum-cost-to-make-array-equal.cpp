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

    vector<long long> prefixCost(n + 1, 0);
    for (int i = 0; i < n; ++i) {
        prefixCost[i + 1] = prefixCost[i] + arr[i].second;
    }

    long long median = 0;
    long long l = 0, r = arr.back().first;
    while (l < r) {
        long long mid = l + (r - l) / 2;
        long long cost1 = 0, cost2 = 0;
        for (int i = 0; i < n; ++i) {
            cost1 += (long long)abs(arr[i].first - mid) * arr[i].second;
            cost2 += (long long)abs(arr[i].first - (mid + 1)) * arr[i].second;
        }

        if (cost1 < cost2) {
            r = mid;
        } else {
            l = mid + 1;
        }
    }

    long long ans = 0;
    for (int i = 0; i < n; ++i) {
        ans += (long long)abs(arr[i].first - l) * arr[i].second;
    }

    return ans;
}