#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> permuteUnique(vector<int>& nums) {
        vector<vector<int>> result;
        vector<int> current;
        vector<bool> used(nums.size(), false);
        sort(nums.begin(), nums.end());

        function<void(void)> backtrack = [&]() {
            if (current.size() == nums.size()) {
                result.push_back(current);
                return;
            }

            for (int i = 0; i < nums.size(); ++i) {
                if (used[i] || (i > 0 && nums[i] == nums[i - 1] && !used[i - 1])) {
                    continue;
                }

                used[i] = true;
                current.push_back(nums[i]);
                backtrack();
                current.pop_back();
                used[i] = false;
            }
        };

        backtrack();
        return result;
    }
};