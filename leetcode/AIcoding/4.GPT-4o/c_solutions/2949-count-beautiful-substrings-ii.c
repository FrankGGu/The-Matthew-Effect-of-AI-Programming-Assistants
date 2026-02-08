int countBeautifulSubstrings(char * s) {
    int n = strlen(s);
    int count = 0;
    int currentCount = 0;
    int lastChar = -1;

    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            currentCount++;
        } else {
            currentCount = 0;
        }

        if (currentCount % 2 == 0) {
            count++;
        }
    }

    return count;
}