int mirrorScore(char *s) {
    int score = 0;
    int length = strlen(s);
    for (int i = 0; i < length; i++) {
        if (s[i] == 'a') {
            score += 1;
        } else if (s[i] == 'b') {
            score += 2;
        } else if (s[i] == 'c') {
            score += 3;
        } else if (s[i] == 'd') {
            score += 4;
        } else if (s[i] == 'e') {
            score += 5;
        } else if (s[i] == 'f') {
            score += 6;
        } else if (s[i] == 'g') {
            score += 7;
        } else if (s[i] == 'h') {
            score += 8;
        } else if (s[i] == 'i') {
            score += 9;
        } else if (s[i] == 'j') {
            score += 10;
        } else if (s[i] == 'k') {
            score += 11;
        } else if (s[i] == 'l') {
            score += 12;
        } else if (s[i] == 'm') {
            score += 13;
        } else if (s[i] == 'n') {
            score += 14;
        } else if (s[i] == 'o') {
            score += 15;
        } else if (s[i] == 'p') {
            score += 16;
        } else if (s[i] == 'q') {
            score += 17;
        } else if (s[i] == 'r') {
            score += 18;
        } else if (s[i] == 's') {
            score += 19;
        } else if (s[i] == 't') {
            score += 20;
        } else if (s[i] == 'u') {
            score += 21;
        } else if (s[i] == 'v') {
            score += 22;
        } else if (s[i] == 'w') {
            score += 23;
        } else if (s[i] == 'x') {
            score += 24;
        } else if (s[i] == 'y') {
            score += 25;
        } else if (s[i] == 'z') {
            score += 26;
        }
    }
    return score;
}