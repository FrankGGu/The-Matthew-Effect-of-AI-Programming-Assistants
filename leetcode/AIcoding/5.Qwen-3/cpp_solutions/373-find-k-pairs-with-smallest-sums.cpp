#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> kSmallestPairs(vector<int>& nums1, vector<int>& nums2, int k) {
        if (nums1.empty() || nums2.empty()) return {};

        auto compare = [&](const pair<int, int>& a, const pair<int, int>& b) {
            return nums1[a.first] + nums2[a.second] > nums1[b.first] + nums2[b.second];
        };

        priority_queue<pair<int, int>, vector<pair<int, int>>, decltype(compare)> minHeap(compare);
        minHeap.emplace(0, 0);

        vector<vector<int>> result;
        while (k-- > 0 && !minHeap.empty()) {
            auto [i, j] = minHeap.top();
            minHeap.pop();
            result.push_back({nums1[i], nums2[j]});

            if (i + 1 < nums1.size()) {
                minHeap.emplace(i + 1, j);
            }
            if (j + 1 < nums2.size()) {
                minHeap.emplace(i, j + 1);
            }
        }

        return result;
    }
};