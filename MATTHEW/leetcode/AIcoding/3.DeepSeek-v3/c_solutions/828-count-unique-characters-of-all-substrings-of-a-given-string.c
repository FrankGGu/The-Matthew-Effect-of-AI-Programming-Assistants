int uniqueLetterString(char* s) {
    int n = strlen(s);
    int lastPos[26][2];
    for (int i = 0; i < 26; i++) {
        lastPos[i][0] = -1;
        lastPos[i][1] = -1;
    }

    int res = 0;
    for (int i = 0; i < n; i++) {
        int c = s[i] - 'A';
        res += (i - lastPos[c][1]) * (lastPos[c][1] - lastPos[c][0]);
        lastPos[c][0] = lastPos[c][1];
        lastPos[c][1] = i;
    }

    for (int c = 0; c < 26; c++) {
        res += (n - lastPos[c][1]) * (lastPos[c][1] - lastPos[c][0]);
    }

    return res;
}