#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> findStableArrays(int n, int k) {
        vector<vector<int>> result;
        vector<int> current(n, 0);

        function<void(int, int)> solve = [&](int index, int current_k) {
            if (index == n) {
                if (current_k == k) {
                    result.push_back(current);
                }
                return;
            }

            current[index] = 0;
            solve(index + 1, current_k);

            current[index] = 1;
            if (index == 0 || current[index - 1] == 0) {
                solve(index + 1, current_k + 1);
            }
        };

        solve(0, 0);
        return result;
    }
};