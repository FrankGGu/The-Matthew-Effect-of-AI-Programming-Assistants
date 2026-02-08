#include <vector>
#include <string>
#include <algorithm>

using namespace std;

vector<int> smallestTrimmedNumbers(vector<string>& nums, vector<vector<int>>& queries) {
    vector<int> result;
    for (auto& query : queries) {
        int k = query[0];
        int trim = query[1];

        vector<pair<string, int>> trimmed_nums;
        for (int i = 0; i < nums.size(); ++i) {
            int len = nums[i].length();
            trimmed_nums.push_back({nums[i].substr(len - trim), i});
        }

        sort(trimmed_nums.begin(), trimmed_nums.end());

        result.push_back(trimmed_nums[k - 1].second);
    }
    return result;
}