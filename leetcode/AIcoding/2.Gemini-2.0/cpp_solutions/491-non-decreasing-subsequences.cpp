#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    vector<vector<int>> findSubsequences(vector<int>& nums) {
        set<vector<int>> result;
        vector<int> current;
        findSubsequencesHelper(nums, 0, current, result);
        return vector<vector<int>>(result.begin(), result.end());
    }

private:
    void findSubsequencesHelper(vector<int>& nums, int index, vector<int>& current, set<vector<int>>& result) {
        if (current.size() >= 2) {
            result.insert(current);
        }

        for (int i = index; i < nums.size(); ++i) {
            if (current.empty() || nums[i] >= current.back()) {
                current.push_back(nums[i]);
                findSubsequencesHelper(nums, i + 1, current, result);
                current.pop_back();
            }
        }
    }
};