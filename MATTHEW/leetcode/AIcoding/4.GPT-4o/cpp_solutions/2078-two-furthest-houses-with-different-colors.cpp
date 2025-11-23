class Solution {
public:
    int maxDistance(vector<int>& colors) {
        int n = colors.size();
        int firstColor = colors[0], lastColor = colors[n - 1];
        int maxDist = 0;

        for (int i = 0; i < n; ++i) {
            if (colors[i] != firstColor) {
                maxDist = max(maxDist, i);
            }
            if (colors[i] != lastColor) {
                maxDist = max(maxDist, n - 1 - i);
            }
        }

        return maxDist;
    }
};