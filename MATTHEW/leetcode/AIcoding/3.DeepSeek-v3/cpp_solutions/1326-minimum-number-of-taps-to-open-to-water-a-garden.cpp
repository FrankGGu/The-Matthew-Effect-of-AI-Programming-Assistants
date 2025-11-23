class Solution {
public:
    int minTaps(int n, vector<int>& ranges) {
        vector<int> jumps(n + 1, 0);
        for (int i = 0; i <= n; ++i) {
            int l = max(0, i - ranges[i]);
            int r = min(n, i + ranges[i]);
            jumps[l] = max(jumps[l], r - l);
        }

        int res = 0, curEnd = 0, curFarthest = 0;
        for (int i = 0; i < n; ++i) {
            curFarthest = max(curFarthest, i + jumps[i]);
            if (i == curEnd) {
                res++;
                curEnd = curFarthest;
                if (curEnd >= n) break;
            }
        }
        return curEnd >= n ? res : -1;
    }
};