class Solution {
public:
    int firstPlayerToWinKGames(vector<vector<int>>& games, int k) {
        unordered_map<int, int> wins;
        unordered_map<int, int> streaks;
        int firstPlayer = -1;

        for (const auto& game : games) {
            int winner = game[0];
            wins[winner]++;
            streaks[winner] = (streaks[winner] == 0) ? 1 : streaks[winner] + 1;

            if (streaks[winner] >= k) {
                if (firstPlayer == -1 || winner < firstPlayer) {
                    firstPlayer = winner;
                }
            } else {
                streaks[winner] = 0;
            }
        }

        return firstPlayer;
    }
};