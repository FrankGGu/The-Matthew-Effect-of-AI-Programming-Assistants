#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> kSmallestPairs(vector<int>& nums1, vector<int>& nums2, int k) {
        vector<vector<int>> result;
        int n1 = nums1.size();
        int n2 = nums2.size();

        auto comp = [&](const pair<int, int>& a, const pair<int, int>& b) {
            return nums1[a.first] + nums2[a.second] > nums1[b.first] + nums2[b.second];
        };

        priority_queue<pair<int, int>, vector<pair<int, int>>, decltype(comp)> pq(comp);

        if (n1 == 0 || n2 == 0) return result;

        for (int i = 0; i < min(n1, k); ++i) {
            pq.push({i, 0});
        }

        while (k > 0 && !pq.empty()) {
            auto curr = pq.top();
            pq.pop();

            result.push_back({nums1[curr.first], nums2[curr.second]});

            if (curr.second + 1 < n2) {
                pq.push({curr.first, curr.second + 1});
            }

            k--;
        }

        return result;
    }
};