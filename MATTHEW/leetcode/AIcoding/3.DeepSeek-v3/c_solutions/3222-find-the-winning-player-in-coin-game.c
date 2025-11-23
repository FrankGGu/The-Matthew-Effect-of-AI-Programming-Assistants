int winningPlayer(int x, int y) {
    int min = x < y ? x : y;
    int max = x > y ? x : y;

    if (min * 4 <= max) {
        return 1;
    } else {
        int moves = 0;
        while (min > 0 && max > 1) {
            min--;
            max -= 2;
            moves++;
        }
        return moves % 2 == 0 ? 0 : 1;
    }
}