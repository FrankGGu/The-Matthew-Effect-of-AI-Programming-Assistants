#include <vector>
#include <queue>
#include <utility>

class Solution {
public:
    std::vector<std::vector<int>> kSmallestPairs(std::vector<int>& nums1, std::vector<int>& nums2, int k) {
        std::vector<std::vector<int>> result;
        if (nums1.empty() || nums2.empty() || k == 0) {
            return result;
        }

        auto cmp = [&](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            return nums1[a.first] + nums2[a.second] > nums1[b.first] + nums2[b.second];
        };

        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, decltype(cmp)> pq(cmp);

        for (int i = 0; i < nums1.size() && i < k; ++i) {
            pq.push({i, 0});
        }

        while (k-- > 0 && !pq.empty()) {
            std::pair<int, int> current_indices = pq.top();
            pq.pop();
            int i = current_indices.first;
            int j = current_indices.second;

            result.push_back({nums1[i], nums2[j]});

            if (j + 1 < nums2.size()) {
                pq.push({i, j + 1});
            }
        }

        return result;
    }
};