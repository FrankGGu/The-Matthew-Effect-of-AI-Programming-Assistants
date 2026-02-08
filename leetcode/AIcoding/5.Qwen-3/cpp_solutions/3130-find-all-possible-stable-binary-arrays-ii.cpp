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

            for (int bit = 0; bit <= 1; ++bit) {
                if (index == 0 || bit != prev) {
                    current[index] = bit;
                    backtrack(index + 1, bit);
                }
            }
        };

        backtrack(0, -1);
        return result;
    }
};