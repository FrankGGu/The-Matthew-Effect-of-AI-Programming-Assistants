class Solution {
public:
    int maxArea(int h, int w, vector<vector<int>>& cuts) {
        vector<int> hCuts, wCuts;
        for (auto& cut : cuts) {
            if (cut[0] == 0) hCuts.push_back(cut[1]);
            else wCuts.push_back(cut[1]);
        }
        hCuts.push_back(0);
        hCuts.push_back(h);
        wCuts.push_back(0);
        wCuts.push_back(w);

        sort(hCuts.begin(), hCuts.end());
        sort(wCuts.begin(), wCuts.end());

        int maxH = 0, maxW = 0;
        for (int i = 1; i < hCuts.size(); i++) {
            maxH = max(maxH, hCuts[i] - hCuts[i - 1]);
        }
        for (int i = 1; i < wCuts.size(); i++) {
            maxW = max(maxW, wCuts[i] - wCuts[i - 1]);
        }

        return maxH * maxW;
    }
};