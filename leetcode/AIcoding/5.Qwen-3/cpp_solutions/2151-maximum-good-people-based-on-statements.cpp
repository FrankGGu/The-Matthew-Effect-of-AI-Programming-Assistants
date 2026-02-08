#include <iostream>
#include <vector>
#include <bitset>

using namespace std;

class Solution {
public:
    int maximumGood(vector<vector<int>>& statements) {
        int n = statements.size();
        int maxGood = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            bool valid = true;
            for (int i = 0; i < n && valid; ++i) {
                if ((mask & (1 << i)) != 0) {                     for (int j = 0; j < n; ++j) {
                        if (i != j && (mask & (1 << j)) != 0) {                             if (statements[i][j] == 0) {
                                valid = false;
                                break;
                            }
                        }
                    }
                }
            }
            if (valid) {
                int count = __builtin_popcount(mask);
                maxGood = max(maxGood, count);
            }
        }

        return maxGood;
    }
};