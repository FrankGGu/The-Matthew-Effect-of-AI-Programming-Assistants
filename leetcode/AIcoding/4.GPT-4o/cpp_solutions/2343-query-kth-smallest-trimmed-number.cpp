#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> smallestTrimmedNumbers(vector<string>& nums, vector<vector<int>>& queries) {
        vector<int> result;
        for (auto& query : queries) {
            int k = query[0], trim = query[1];
            vector<pair<string, int>> trimmed;
            for (int i = 0; i < nums.size(); i++) {
                trimmed.emplace_back(nums[i].substr(nums[i].size() - trim), i);
            }
            sort(trimmed.begin(), trimmed.end());
            result.push_back(trimmed[k - 1].second);
        }
        return result;
    }
};