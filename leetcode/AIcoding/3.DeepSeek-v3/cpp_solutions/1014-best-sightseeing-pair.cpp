class Solution {
public:
    int maxScoreSightseeingPair(vector<int>& values) {
        int n = values.size();
        int maxLeft = values[0] + 0;
        int ans = INT_MIN;
        for (int j = 1; j < n; j++) {
            ans = max(ans, maxLeft + values[j] - j);
            maxLeft = max(maxLeft, values[j] + j);
        }
        return ans;
    }
};