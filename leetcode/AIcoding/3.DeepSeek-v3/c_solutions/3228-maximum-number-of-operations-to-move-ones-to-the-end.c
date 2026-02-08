int maxOperations(char* s) {
    int count = 0;
    int ones = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        if (s[i] == '1') {
            ones++;
        } else if (ones > 0) {
            count += ones;
        }
    }

    return count;
}