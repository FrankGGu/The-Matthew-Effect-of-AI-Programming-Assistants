class Solution {
public:
    int beautifulTowers(vector<int>& heights) {
        int n = heights.size();
        sort(heights.begin(), heights.end());
        int count = 0;

        for (int i = 0; i < n; ++i) {
            if ((i == 0 || heights[i] != heights[i - 1]) && (i == n - 1 || heights[i] != heights[i + 1])) {
                count++;
            }
        }

        return count;
    }
};