#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> combinationSum3(int k, int n) {
        vector<vector<int>> result;
        vector<int> combination;
        solve(result, combination, k, n, 1);
        return result;
    }

private:
    void solve(vector<vector<int>>& result, vector<int>& combination, int k, int n, int start) {
        if (k == 0) {
            if (n == 0) {
                result.push_back(combination);
            }
            return;
        }

        for (int i = start; i <= 9; ++i) {
            combination.push_back(i);
            solve(result, combination, k - 1, n - i, i + 1);
            combination.pop_back();
        }
    }
};