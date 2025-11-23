int minimumMoves(char * s) {
    int moves = 0;
    int i = 0;
    int len = strlen(s);

    while (i < len) {
        if (s[i] == 'X') {
            moves++;
            i += 3;
        } else {
            i++;
        }
    }

    return moves;
}