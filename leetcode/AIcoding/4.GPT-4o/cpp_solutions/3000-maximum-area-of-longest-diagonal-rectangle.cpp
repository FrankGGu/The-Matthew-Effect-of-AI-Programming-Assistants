class Solution {
public:
    int maxArea(int h, int w, vector<vector<int>>& corners) {
        set<int> hSet, wSet;
        hSet.insert(0);
        hSet.insert(h);
        wSet.insert(0);
        wSet.insert(w);

        for (const auto& corner : corners) {
            hSet.insert(corner[0]);
            wSet.insert(corner[1]);
        }

        vector<int> hList(hSet.begin(), hSet.end());
        vector<int> wList(wSet.begin(), wSet.end());

        int maxH = 0, maxW = 0;
        for (int i = 1; i < hList.size(); ++i) {
            maxH = max(maxH, hList[i] - hList[i - 1]);
        }
        for (int i = 1; i < wList.size(); ++i) {
            maxW = max(maxW, wList[i] - wList[i - 1]);
        }

        return maxH * maxW;
    }
};