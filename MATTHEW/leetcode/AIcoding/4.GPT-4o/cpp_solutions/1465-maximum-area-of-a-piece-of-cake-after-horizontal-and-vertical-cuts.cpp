class Solution {
public:
    int maxArea(int h, int w, vector<int>& horizontalCuts, vector<int>& verticalCuts) {
        sort(horizontalCuts.begin(), horizontalCuts.end());
        sort(verticalCuts.begin(), verticalCuts.end());

        long maxH = horizontalCuts.empty() ? h : horizontalCuts[0];
        for (int i = 1; i < horizontalCuts.size(); ++i) {
            maxH = max(maxH, (long)horizontalCuts[i] - horizontalCuts[i - 1]);
        }
        maxH = max(maxH, (long)h - horizontalCuts.back());

        long maxW = verticalCuts.empty() ? w : verticalCuts[0];
        for (int i = 1; i < verticalCuts.size(); ++i) {
            maxW = max(maxW, (long)verticalCuts[i] - verticalCuts[i - 1]);
        }
        maxW = max(maxW, (long)w - verticalCuts.back());

        return (maxH % 1000000007) * (maxW % 1000000007) % 1000000007;
    }
};