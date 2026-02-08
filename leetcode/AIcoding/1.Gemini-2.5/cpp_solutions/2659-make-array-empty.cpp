#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

long long countOperationsToEmptyArray(vector<int>& nums) {
    int n = nums.size();
    vector<pair<int, int>> arr(n);
    for (int i = 0; i < n; ++i) {
        arr[i] = {nums[i], i};
    }
    sort(arr.begin(), arr.end());

    vector<int> bit(n + 1, 0);
    auto update = [&](int i, int val) {
        for (; i <= n; i += (i & -i)) {
            bit[i] += val;
        }
    };

    auto query = [&](int i) {
        int sum = 0;
        for (; i > 0; i -= (i & -i)) {
            sum += bit[i];
        }
        return sum;
    };

    long long ans = 0;
    for (int i = 0; i < n; ++i) {
        int idx = arr[i].second + 1;
        int smaller = query(idx);
        if (i == 0) {
            ans += idx - 1;
        } else {
            int prev_idx = arr[i - 1].second + 1;
            if(idx > prev_idx){
                ans += (idx - 1) - smaller;
            } else {
                ans += (n - smaller) + (idx - 1);
            }
        }
        update(idx, 1);
    }
    return ans;
}