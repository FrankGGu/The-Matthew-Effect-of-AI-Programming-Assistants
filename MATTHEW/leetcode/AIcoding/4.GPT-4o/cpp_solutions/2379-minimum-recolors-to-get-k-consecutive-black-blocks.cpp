class Solution {
public:
    int minimumRecolors(string blocks, int k) {
        int n = blocks.size();
        int minRecolors = INT_MAX;
        int currentRecolors = 0;

        for (int i = 0; i < n; ++i) {
            if (blocks[i] == 'W') {
                currentRecolors++;
            }
            if (i >= k) {
                if (blocks[i - k] == 'W') {
                    currentRecolors--;
                }
            }
            if (i >= k - 1) {
                minRecolors = min(minRecolors, currentRecolors);
            }
        }

        return minRecolors;
    }
};