#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> kSmallestPairs(vector<int>& nums1, vector<int>& nums2, int k) {
        auto comp = [&](const pair<int, int>& a, const pair<int, int>& b) {
            return nums1[a.first] + nums2[a.second] > nums1[b.first] + nums2[b.second];
        };

        priority_queue<pair<int, int>, vector<pair<int, int>>, decltype(comp)> pq(comp);
        vector<vector<int>> result;

        for (int i = 0; i < nums1.size() && i < k; ++i) {
            pq.push({i, 0});
        }

        while (k-- > 0 && !pq.empty()) {
            auto [i, j] = pq.top();
            pq.pop();
            result.push_back({nums1[i], nums2[j]});

            if (j + 1 < nums2.size()) {
                pq.push({i, j + 1});
            }
        }

        return result;
    }
};