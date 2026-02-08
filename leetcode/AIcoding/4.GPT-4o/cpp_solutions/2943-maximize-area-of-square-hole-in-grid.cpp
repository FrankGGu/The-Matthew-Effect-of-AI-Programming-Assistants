class Solution {
public:
    int maxArea(int h, int w, vector<vector<int>>& cuts) {
        vector<int> xCuts = {0, h}, yCuts = {0, w};
        for (auto& cut : cuts) {
            if (cut[0] == 0) {
                xCuts.push_back(cut[1]);
            } else {
                yCuts.push_back(cut[1]);
            }
        }
        sort(xCuts.begin(), xCuts.end());
        sort(yCuts.begin(), yCuts.end());

        int maxHeight = 0, maxWidth = 0;
        for (int i = 1; i < xCuts.size(); i++) {
            maxHeight = max(maxHeight, xCuts[i] - xCuts[i - 1]);
        }
        for (int i = 1; i < yCuts.size(); i++) {
            maxWidth = max(maxWidth, yCuts[i] - yCuts[i - 1]);
        }

        return min(maxHeight, maxWidth) * min(maxHeight, maxWidth);
    }
};