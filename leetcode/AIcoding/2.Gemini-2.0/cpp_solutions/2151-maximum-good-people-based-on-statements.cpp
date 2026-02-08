#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumGood(vector<vector<int>>& statements) {
        int n = statements.size();
        int maxGood = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            int goodCount = 0;
            bool valid = true;

            for (int i = 0; i < n; ++i) {
                if ((mask >> i) & 1) {
                    goodCount++;
                }
            }

            for (int i = 0; i < n; ++i) {
                if ((mask >> i) & 1) { 
                    for (int j = 0; j < n; ++j) {
                        if (statements[i][j] == 0) continue;
                        if (statements[i][j] == 1 && !((mask >> j) & 1)) {
                            valid = false;
                            break;
                        }
                        if (statements[i][j] == 2 && ((mask >> j) & 1)) {
                            valid = false;
                            break;
                        }
                    }
                }
                if (!valid) break;
            }

            if (valid) {
                maxGood = max(maxGood, goodCount);
            }
        }

        return maxGood;
    }
};