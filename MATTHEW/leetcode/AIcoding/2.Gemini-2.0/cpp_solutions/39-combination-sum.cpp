#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
        vector<vector<int>> result;
        vector<int> combination;
        sort(candidates.begin(), candidates.end());

        function<void(int, int)> backtrack = [&](int start, int remaining) {
            if (remaining == 0) {
                result.push_back(combination);
                return;
            }

            if (remaining < 0) {
                return;
            }

            for (int i = start; i < candidates.size(); ++i) {
                combination.push_back(candidates[i]);
                backtrack(i, remaining - candidates[i]);
                combination.pop_back();
            }
        };

        backtrack(0, target);
        return result;
    }
};