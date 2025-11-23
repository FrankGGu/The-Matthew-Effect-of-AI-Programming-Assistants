class Solution {
public:
    int minQueenMoves(string king, string queen) {
        int king_x = king[0] - 'a', king_y = king[1] - '1';
        int queen_x = queen[0] - 'a', queen_y = queen[1] - '1';

        if (king_x == queen_x || king_y == queen_y || abs(king_x - queen_x) == abs(king_y - queen_y)) {
            return 1;
        }

        return 2;
    }
};