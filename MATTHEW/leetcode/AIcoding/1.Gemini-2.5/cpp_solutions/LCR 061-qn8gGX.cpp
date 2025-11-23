#include <vector>
#include <queue>
#include <functional>

class Solution {
public:
    std::vector<std::vector<int>> kSmallestPairs(std::vector<int>& nums1, std::vector<int>& nums2, int k) {
        std::vector<std::vector<int>> result;
        if (nums1.empty() || nums2.empty() || k == 0) {
            return result;
        }

        std::priority_queue<std::vector<int>, std::vector<std::vector<int>>, std::greater<std::vector<int>>> pq;

        for (int i = 0; i < nums1.size() && i < k; ++i) {
            pq.push({nums1[i] + nums2[0], i, 0});
        }

        while (k > 0 && !pq.empty()) {
            std::vector<int> current = pq.top();
            pq.pop();

            int idx1 = current[1];
            int idx2 = current[2];

            result.push_back({nums1[idx1], nums2[idx2]});
            k--;

            if (idx2 + 1 < nums2.size()) {
                pq.push({nums1[idx1] + nums2[idx2 + 1], idx1, idx2 + 1});
            }
        }

        return result;
    }
};