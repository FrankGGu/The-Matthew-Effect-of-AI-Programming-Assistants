int furthestDistanceFromOrigin(char *moves) {
    int x = 0, y = 0;
    while (*moves) {
        if (*moves == 'L') x--;
        else if (*moves == 'R') x++;
        else if (*moves == 'U') y++;
        else if (*moves == 'D') y--;
        moves++;
    }
    return abs(x) + abs(y);
}