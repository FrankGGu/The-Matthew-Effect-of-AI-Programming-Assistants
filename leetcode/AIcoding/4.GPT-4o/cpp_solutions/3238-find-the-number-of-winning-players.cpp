class Solution {
public:
    int numberOfWinningPlayers(vector<int>& players, int k) {
        int n = players.size();
        vector<int> wins(n, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (players[i] > players[j]) {
                    wins[i]++;
                }
            }
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (wins[i] >= k) {
                count++;
            }
        }

        return count;
    }
};