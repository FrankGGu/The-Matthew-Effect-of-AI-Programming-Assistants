#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> rangeFreqQueries(vector<int>& nums, vector<vector<int>>& queries) {
        map<int, vector<int>> pos;
        for (int i = 0; i < nums.size(); ++i) {
            pos[nums[i]].push_back(i);
        }

        vector<int> result;
        for (const auto& q : queries) {
            int left = q[0];
            int right = q[1];
            int target = q[2];
            const vector<int>& indices = pos[target];
            auto l = lower_bound(indices.begin(), indices.end(), left);
            auto r = upper_bound(indices.begin(), indices.end(), right);
            result.push_back(r - l);
        }
        return result;
    }
};