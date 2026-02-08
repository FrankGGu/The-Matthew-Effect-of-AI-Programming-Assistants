#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> combine(int n, int k) {
        vector<vector<int>> result;
        vector<int> combination;

        function<void(int)> backtrack = [&](int start) {
            if (combination.size() == k) {
                result.push_back(combination);
                return;
            }

            for (int i = start; i <= n; ++i) {
                combination.push_back(i);
                backtrack(i + 1);
                combination.pop_back();
            }
        };

        backtrack(1);
        return result;
    }
};