class Solution {
public:
    int minMoves(int target, int maxDoubles) {
        if (target == 1) {
            return 0;
        }

        int moves = 0;
        while (target > 1) {
            if (maxDoubles > 0) {
                if (target % 2 == 0) {
                    target /= 2;
                    maxDoubles--;
                } else {
                    target--;
                }
            } else {
                moves += (target - 1);
                target = 1;
                break;
            }
            moves++;
        }
        return moves;
    }
};