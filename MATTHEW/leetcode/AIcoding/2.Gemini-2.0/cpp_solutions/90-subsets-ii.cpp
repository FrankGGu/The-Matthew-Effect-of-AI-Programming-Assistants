#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> subsetsWithDup(vector<int>& nums) {
        vector<vector<int>> result;
        vector<int> subset;
        sort(nums.begin(), nums.end());
        subsetsWithDupHelper(nums, 0, subset, result);
        return result;
    }

private:
    void subsetsWithDupHelper(vector<int>& nums, int index, vector<int>& subset, vector<vector<int>>& result) {
        result.push_back(subset);

        for (int i = index; i < nums.size(); ++i) {
            if (i > index && nums[i] == nums[i - 1]) {
                continue;
            }
            subset.push_back(nums[i]);
            subsetsWithDupHelper(nums, i + 1, subset, result);
            subset.pop_back();
        }
    }
};