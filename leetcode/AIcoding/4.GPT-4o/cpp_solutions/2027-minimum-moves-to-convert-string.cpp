class Solution {
public:
    int minimumMoves(string s) {
        int moves = 0;
        for (int i = 0; i < s.size(); ) {
            if (s[i] == 'X') {
                moves++;
                i += 3;
            } else {
                i++;
            }
        }
        return moves;
    }
};