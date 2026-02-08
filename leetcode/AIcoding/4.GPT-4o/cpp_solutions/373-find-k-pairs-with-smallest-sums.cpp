#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    vector<vector<int>> kSmallestPairs(vector<int>& nums1, vector<int>& nums2, int k) {
        priority_queue<pair<int, pair<int, int>>> maxHeap;
        vector<vector<int>> result;

        for (int i = 0; i < min((int)nums1.size(), k); ++i) {
            for (int j = 0; j < min((int)nums2.size(), k); ++j) {
                int sum = nums1[i] + nums2[j];
                if (maxHeap.size() < k) {
                    maxHeap.push({sum, {nums1[i], nums2[j]}});
                } else if (sum < maxHeap.top().first) {
                    maxHeap.pop();
                    maxHeap.push({sum, {nums1[i], nums2[j]}});
                }
            }
        }

        while (!maxHeap.empty()) {
            auto pair = maxHeap.top().second;
            result.push_back({pair.first, pair.second});
            maxHeap.pop();
        }

        reverse(result.begin(), result.end());
        return result;
    }
};