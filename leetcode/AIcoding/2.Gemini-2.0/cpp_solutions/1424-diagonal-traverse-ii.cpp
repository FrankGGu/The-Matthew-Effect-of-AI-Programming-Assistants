#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findDiagonalOrder(vector<vector<int>>& nums) {
        vector<pair<int, int>> elements;
        for (int i = 0; i < nums.size(); ++i) {
            for (int j = 0; j < nums[i].size(); ++j) {
                elements.push_back({i + j, i});
            }
        }

        sort(elements.begin(), elements.end());

        vector<int> result;
        for (auto& p : elements) {
            result.push_back(nums[p.second][p.first - p.second]);
        }

        return result;
    }
};