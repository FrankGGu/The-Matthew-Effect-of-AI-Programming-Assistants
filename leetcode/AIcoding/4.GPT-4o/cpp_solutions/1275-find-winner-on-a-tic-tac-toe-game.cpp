class Solution {
public:
    string tictactoe(vector<vector<int>>& moves) {
        vector<int> rows(3, 0), cols(3, 0);
        int diag1 = 0, diag2 = 0;

        for (int i = 0; i < moves.size(); i++) {
            int player = (i % 2 == 0) ? 1 : -1;
            int r = moves[i][0], c = moves[i][1];
            rows[r] += player;
            cols[c] += player;
            if (r == c) diag1 += player;
            if (r + c == 2) diag2 += player;

            if (abs(rows[r]) == 3 || abs(cols[c]) == 3 || abs(diag1) == 3 || abs(diag2) == 3) {
                return player == 1 ? "A" : "B";
            }
        }

        return moves.size() == 9 ? "Draw" : "Pending";
    }
};