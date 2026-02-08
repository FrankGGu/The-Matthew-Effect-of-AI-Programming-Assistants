class Solution {
public:
    int beautifulTowers(vector<int>& heights) {
        int n = heights.size();
        sort(heights.begin(), heights.end());
        int res = 0;
        for (int i = 1; i < n; i++) {
            if (heights[i] != heights[i - 1]) {
                res++;
            }
        }
        return res + 1;
    }
};