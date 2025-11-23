class Solution {
public:
    int minSwaps(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<int> zeroCount(n);

        for (int i = 0; i < n; ++i) {
            int count = 0;
            for (int j = n - 1; j >= 0; --j) {
                if (grid[i][j] == 0) count++;
                else break;
            }
            zeroCount[i] = count;
        }

        int swaps = 0;
        for (int i = 0; i < n; ++i) {
            int requiredZeros = n - 1 - i;
            if (zeroCount[i] < requiredZeros) {
                int j = i;
                while (j < n && zeroCount[j] < requiredZeros) {
                    j++;
                }
                if (j == n) return -1;
                for (; j > i; j--) {
                    swap(zeroCount[j], zeroCount[j - 1]);
                    swaps++;
                }
            }
        }
        return swaps;
    }
};