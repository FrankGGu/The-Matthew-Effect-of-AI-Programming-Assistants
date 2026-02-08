#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSwaps(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<int> trailingZeros(n, 0);
        for (int i = 0; i < n; ++i) {
            int count = 0;
            for (int j = n - 1; j >= 0; --j) {
                if (grid[i][j] == 0) {
                    count++;
                } else {
                    break;
                }
            }
            trailingZeros[i] = count;
        }

        int swaps = 0;
        for (int i = 0; i < n; ++i) {
            int requiredZeros = n - i - 1;
            if (trailingZeros[i] >= requiredZeros) {
                continue;
            }

            int j = i + 1;
            while (j < n && trailingZeros[j] < requiredZeros) {
                j++;
            }

            if (j == n) {
                return -1;
            }

            for (int k = j; k > i; --k) {
                swap(trailingZeros[k], trailingZeros[k - 1]);
                swaps++;
            }
        }

        return swaps;
    }
};