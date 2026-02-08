class Solution {
public:
    int maxCoins(vector<vector<int>>& piles, int k) {
        int n = piles.size();
        vector<int> prefixSum(n);

        for (int i = 0; i < n; ++i) {
            int sum = 0;
            for (int j = 0; j < piles[i].size(); ++j) {
                sum += piles[i][j];
                if (j == 0) {
                    prefixSum[i] = sum;
                } else {
                    prefixSum[i] = max(prefixSum[i], sum);
                }
            }
        }

        int maxCoins = 0;
        for (int i = 0; i < min(k, n) + 1; ++i) {
            int coins = 0;
            for (int j = 0; j < i; ++j) {
                coins += prefixSum[j];
            }
            int remainingK = k - i;
            if (remainingK > 0) {
                for (int j = n - 1; j >= n - remainingK && j >= 0; --j) {
                    coins += prefixSum[j];
                }
            }
            maxCoins = max(maxCoins, coins);
        }

        return maxCoins;
    }
};