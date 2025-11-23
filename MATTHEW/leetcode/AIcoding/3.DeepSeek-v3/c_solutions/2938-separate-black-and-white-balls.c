long long minimumSteps(char* s) {
    long long swaps = 0;
    int whiteCount = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '0') {
            whiteCount++;
        } else {
            swaps += whiteCount;
        }
    }

    return swaps;
}