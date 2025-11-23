#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> queryIndices(vector<string>& nums, vector<vector<int>>& queries) {
        vector<int> result;
        for (const auto& query : queries) {
            int k = query[0];
            int t = query[1];
            vector<pair<string, int>> trimmed;
            for (int i = 0; i < nums.size(); ++i) {
                string trimmedNum = nums[i].substr(nums[i].size() - t);
                trimmed.push_back({trimmedNum, i});
            }
            sort(trimmed.begin(), trimmed.end());
            result.push_back(trimmed[k - 1].second);
        }
        return result;
    }
};