#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums1, vector<int>& nums2, int k) {
        vector<pair<int, int>> pairs;
        int n = nums1.size();
        for (int i = 0; i < n; ++i) {
            pairs.emplace_back(nums2[i], nums1[i]);
        }
        sort(pairs.rbegin(), pairs.rend());

        priority_queue<int, vector<int>, greater<int>> min_heap;
        long long sum = 0;
        long long res = 0;

        for (int i = 0; i < k - 1; ++i) {
            sum += pairs[i].second;
            min_heap.push(pairs[i].second);
        }

        for (int i = k - 1; i < n; ++i) {
            sum += pairs[i].second;
            min_heap.push(pairs[i].second);
            res = max(res, sum * pairs[i].first);
            sum -= min_heap.top();
            min_heap.pop();
        }

        return res;
    }
};