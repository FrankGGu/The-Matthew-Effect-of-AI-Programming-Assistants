#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> stableBinaryArrays(int n) {
        vector<vector<int>> result;
        vector<int> current(n, 0);

        function<void(int, int)> backtrack = [&](int index, int prev) {
            if (index == n) {
                result.push_back(current);
                return;
            }

            for (int i = 0; i <= 1; ++i) {
                if (i != prev) {
                    current[index] = i;
                    backtrack(index + 1, i);
                }
            }
        };

        backtrack(0, -1);
        return result;
    }
};