#include <vector>
#include <algorithm>

using namespace std;

long long minCost(vector<int>& nums1, vector<int>& nums2, vector<int>& cost) {
    int n = nums1.size();
    vector<pair<int, int>> diff;
    long long sum = 0;
    for (int i = 0; i < n; ++i) {
        int d = nums2[i] - nums1[i];
        sum += d;
        diff.push_back({d, cost[i]});
    }

    if (sum != 0) {
        return -1;
    }

    sort(diff.begin(), diff.end());

    long long ans = 0;
    int l = 0, r = n - 1;
    while (l < r) {
        if (diff[l].first == 0) {
            l++;
            continue;
        }
        if (diff[r].first == 0) {
            r--;
            continue;
        }

        if (diff[l].first + diff[r].first > 0) {
            long long transfer = min((long long)-diff[l].first, (long long)diff[r].first);
            ans += transfer * (diff[l].second + diff[r].second);
            diff[l].first += transfer;
            diff[r].first -= transfer;
        } else {
            long long transfer = min((long long)-diff[l].first, (long long)diff[r].first);
            ans += transfer * (diff[l].second + diff[r].second);
            diff[l].first += transfer;
            diff[r].first -= transfer;
        }

        if (diff[l].first == 0) l++;
        if (diff[r].first == 0) r--;
    }

    return ans;
}