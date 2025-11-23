#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> permuteUnique(vector<int>& nums) {
        vector<vector<int>> result;
        sort(nums.begin(), nums.end());

        function<void(vector<int>&, vector<bool>&, vector<int>&)> backtrack = 
            [&](vector<int>& current_permutation, vector<bool>& used, vector<int>& nums_copy) {
            if (current_permutation.size() == nums_copy.size()) {
                result.push_back(current_permutation);
                return;
            }

            for (int i = 0; i < nums_copy.size(); ++i) {
                if (used[i]) continue;
                if (i > 0 && nums_copy[i] == nums_copy[i - 1] && !used[i - 1]) continue;

                used[i] = true;
                current_permutation.push_back(nums_copy[i]);
                backtrack(current_permutation, used, nums_copy);
                current_permutation.pop_back();
                used[i] = false;
            }
        };

        vector<bool> used(nums.size(), false);
        vector<int> current_permutation;
        backtrack(current_permutation, used, nums);

        return result;
    }
};