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

        for (int i = 0; i < min(n1, k); ++i) {
            pq.push({i, 0});
        }

        while (k > 0 && !pq.empty()) {
            auto p = pq.top();
            pq.pop();
            result.push_back({nums1[p.first], nums2[p.second]});

            if (p.second + 1 < n2) {
                pq.push({p.first, p.second + 1});
            }
            k--;
        }

        return result;
    }
};