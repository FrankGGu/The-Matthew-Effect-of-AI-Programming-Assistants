int furthestDistanceFromOrigin(char* moves) {
    int left = 0, right = 0, blank = 0;
    for (int i = 0; moves[i] != '\0'; i++) {
        if (moves[i] == 'L') left++;
        else if (moves[i] == 'R') right++;
        else blank++;
    }
    return abs(left - right) + blank;
}