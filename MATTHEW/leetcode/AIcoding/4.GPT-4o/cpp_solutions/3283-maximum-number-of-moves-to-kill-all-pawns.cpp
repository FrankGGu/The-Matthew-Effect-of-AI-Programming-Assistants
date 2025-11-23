class Solution {
public:
    int numberOfMoves(string pawns) {
        int leftMoves = 0, rightMoves = 0;
        int n = pawns.size();

        for (int i = 0; i < n; ++i) {
            if (pawns[i] == 'P') {
                leftMoves += i;
                rightMoves += n - 1 - i;
            }
        }
        return min(leftMoves, rightMoves);
    }
};