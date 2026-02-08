class Solution {
public:
    int maxScore(vector<int>& cardPoints, int k) {
        int n = cardPoints.size();
        int total = accumulate(cardPoints.begin(), cardPoints.end(), 0);
        if (k >= n) return total;

        int minWindowSum = INT_MAX;
        int currentWindowSum = 0;

        for (int i = 0; i < n - k; i++) {
            currentWindowSum += cardPoints[i];
        }
        minWindowSum = min(minWindowSum, currentWindowSum);

        for (int i = n - k; i < n; i++) {
            currentWindowSum += cardPoints[i];
            currentWindowSum -= cardPoints[i - (n - k)];
            minWindowSum = min(minWindowSum, currentWindowSum);
        }

        return total - minWindowSum;
    }
};