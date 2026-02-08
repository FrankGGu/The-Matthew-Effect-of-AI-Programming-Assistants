#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumGood(std::vector<std::vector<int>>& statements) {
        int n = statements.size();
        int maxGood = 0;

        for (int mask = 1; mask < (1 << n); ++mask) {
            bool possible = true;
            for (int i = 0; i < n; ++i) {
                if (!((mask >> i) & 1)) {
                    continue;
                }
                for (int j = 0; j < n; ++j) {
                    if (statements[i][j] != 2 && statements[i][j] != ((mask >> j) & 1)) {
                        possible = false;
                        break;
                    }
                }
                if (!possible) {
                    break;
                }
            }

            if (possible) {
                int currentGood = 0;
                for(int k=0; k<n; ++k) {
                    if((mask >> k) & 1) {
                        currentGood++;
                    }
                }
                maxGood = std::max(maxGood, currentGood);
            }
        }

        return maxGood;
    }
};