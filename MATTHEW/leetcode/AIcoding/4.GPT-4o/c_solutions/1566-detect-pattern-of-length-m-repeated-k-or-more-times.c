bool containsPattern(char * s, int m, int k) {
    int len = strlen(s);
    for (int i = 0; i <= len - m * k; i++) {
        int count = 0;
        for (int j = 0; j < k; j++) {
            if (strncmp(s + i, s + i + j * m, m) == 0) {
                count++;
            } else {
                break;
            }
        }
        if (count >= k) {
            return true;
        }
    }
    return false;
}