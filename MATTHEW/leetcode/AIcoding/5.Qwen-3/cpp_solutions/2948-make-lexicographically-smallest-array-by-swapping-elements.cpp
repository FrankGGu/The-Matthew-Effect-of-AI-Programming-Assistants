#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> lexicographicallySmallestArray(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> result(n);
        vector<bool> used(n, false);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;

        for (int i = 0; i < n; ++i) {
            pq.push({nums[i], i});
        }

        int pos = 0;
        while (!pq.empty()) {
            auto [val, idx] = pq.top();
            pq.pop();

            if (used[idx]) continue;

            int count = 0;
            int j = idx;
            while (j < n && !used[j]) {
                ++count;
                ++j;
            }

            if (count <= k) {
                for (int i = idx; i < n && !used[i]; ++i) {
                    result[pos++] = nums[i];
                    used[i] = true;
                }
                k -= count;
            } else {
                int remaining = k;
                int i = idx;
                while (remaining > 0 && i < n && !used[i]) {
                    result[pos++] = nums[i];
                    used[i] = true;
                    --remaining;
                    ++i;
                }
                k = 0;
            }
        }

        return result;
    }
};