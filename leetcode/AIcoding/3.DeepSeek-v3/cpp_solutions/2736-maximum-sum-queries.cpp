#include <vector>
#include <algorithm>
#include <set>
using namespace std;

class Solution {
public:
    vector<int> maximumSumQueries(vector<int>& nums1, vector<int>& nums2, vector<vector<int>>& queries) {
        int n = nums1.size();
        vector<pair<int, int>> nums;
        for (int i = 0; i < n; ++i) {
            nums.emplace_back(nums1[i], nums2[i]);
        }
        sort(nums.begin(), nums.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first > b.first;
        });

        vector<tuple<int, int, int>> qs;
        for (int i = 0; i < queries.size(); ++i) {
            qs.emplace_back(queries[i][0], queries[i][1], i);
        }
        sort(qs.begin(), qs.end(), [](const tuple<int, int, int>& a, const tuple<int, int, int>& b) {
            return get<0>(a) > get<0>(b);
        });

        vector<int> res(queries.size(), -1);
        set<pair<int, int>> s;
        int j = 0;
        for (auto& [x, y, idx] : qs) {
            while (j < n && nums[j].first >= x) {
                int sum = nums[j].first + nums[j].second;
                auto it = s.lower_bound({nums[j].second, -1});
                while (it != s.end() && it->second <= sum) {
                    it = s.erase(it);
                }
                if (it == s.begin() || prev(it)->second < sum) {
                    s.insert({nums[j].second, sum});
                }
                ++j;
            }
            auto it = s.lower_bound({y, -1});
            if (it != s.end()) {
                res[idx] = it->second;
            }
        }
        return res;
    }
};