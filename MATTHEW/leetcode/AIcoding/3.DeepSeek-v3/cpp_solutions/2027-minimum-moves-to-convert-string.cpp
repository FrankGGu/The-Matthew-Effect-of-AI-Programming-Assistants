class Solution {
public:
    int minimumMoves(string s) {
        int n = s.size();
        int moves = 0;
        for (int i = 0; i < n; ) {
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