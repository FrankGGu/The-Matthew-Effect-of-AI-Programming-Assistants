class Solution {
public:
    int stoneGameVIII(vector<int>& stones) {
        int n = stones.size();
        for (int i = 1; i < n; ++i) {
            stones[i] += stones[i - 1];
        }
        int maxScore = stones[n - 1];
        int result = maxScore;
        for (int i = n - 2; i >= 1; --i) {
            result = max(result, stones[i] - result);
        }
        return result;
    }
};