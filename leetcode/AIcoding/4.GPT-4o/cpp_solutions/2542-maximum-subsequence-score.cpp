#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums1, vector<int>& nums2, int k) {
        int n = nums1.size();
        vector<pair<int, int>> pairs(n);

        for (int i = 0; i < n; ++i) {
            pairs[i] = {nums2[i], nums1[i]};
        }

        sort(pairs.rbegin(), pairs.rend());

        long long sum = 0, result = 0;
        priority_queue<int, vector<int>, greater<int>> minHeap;

        for (int i = 0; i < k; ++i) {
            sum += pairs[i].second;
            minHeap.push(pairs[i].second);
        }
        result = sum * pairs[k-1].first;

        for (int i = k; i < n; ++i) {
            sum += pairs[i].second;
            minHeap.push(pairs[i].second);
            sum -= minHeap.top();
            minHeap.pop();
            result = max(result, sum * pairs[i].first);
        }

        return result;
    }
};