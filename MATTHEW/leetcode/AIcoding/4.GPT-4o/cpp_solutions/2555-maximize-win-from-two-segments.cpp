class Solution {
public:
    int maximizeWin(vector<int>& piles, int k) {
        sort(piles.begin(), piles.end());
        int n = piles.size();
        int maxWins = 0;
        int j = 0;

        for (int i = 0; i < n; ++i) {
            while (j < n && piles[j] - piles[i] <= k) {
                ++j;
            }
            maxWins = max(maxWins, j - i);
        }

        return maxWins;
    }
};