#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findDiagonalOrder(vector<vector<int>>& nums) {
        vector<vector<int>> groups;
        for (int i = 0; i < nums.size(); ++i) {
            for (int j = 0; j < nums[i].size(); ++j) {
                if (i + j >= groups.size()) {
                    groups.resize(i + j + 1);
                }
                groups[i + j].push_back(nums[i][j]);
            }
        }

        vector<int> result;
        for (auto& group : groups) {
            reverse(group.begin(), group.end());
            for (int num : group) {
                result.push_back(num);
            }
        }
        return result;
    }
};