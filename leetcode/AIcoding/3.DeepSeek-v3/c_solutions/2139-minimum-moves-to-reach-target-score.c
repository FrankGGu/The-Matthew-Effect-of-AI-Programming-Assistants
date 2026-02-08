int minMoves(int target, int maxDoubles) {
    int moves = 0;
    while (target > 1 && maxDoubles > 0) {
        if (target % 2 == 1) {
            target--;
            moves++;
        } else {
            target /= 2;
            moves++;
            maxDoubles--;
        }
    }
    return moves + (target - 1);
}