class Solution {
public:
    int maxCoins(vector<int>& piles) {
        sort(piles.begin(), piles.end());
        int n = piles.size() / 3;
        int maxCoins = 0;
        for (int i = n; i < 2 * n; ++i) {
            maxCoins += piles[i];
        }
        return maxCoins;
    }
};