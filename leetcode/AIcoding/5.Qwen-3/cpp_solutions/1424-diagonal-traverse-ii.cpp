#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> findDiagonalOrder(vector<vector<int>>& nums) {
        vector<vector<int>> groups;
        for (int i = 0; i < nums.size(); ++i) {
            for (int j = 0; j < nums[i].size(); ++j) {
                if (groups.size() <= i + j) {
                    groups.resize(i + j + 1);
                }
                groups[i + j].push_back(nums[i][j]);
            }
        }
        vector<int> result;
        for (auto& group : groups) {
            for (int i = group.size() - 1; i >= 0; --i) {
                result.push_back(group[i]);
            }
        }
        return result;
    }
};