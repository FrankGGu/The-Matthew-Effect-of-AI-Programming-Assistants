int minimumMoves(char* s) {
    int moves = 0;
    int i = 0;
    while (s[i] != '\0') {
        if (s[i] == 'X') {
            moves++;
            i += 3;
        } else {
            i++;
        }
    }
    return moves;
}