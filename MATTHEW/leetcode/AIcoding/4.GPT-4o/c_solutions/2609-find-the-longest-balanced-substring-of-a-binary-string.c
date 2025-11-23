int findTheLongestBalancedSubstring(char * s) {
    int maxLength = 0;
    int count0 = 0, count1 = 0;
    int length = strlen(s);

    for (int i = 0; i < length; i++) {
        if (s[i] == '0') {
            if (count1 > 0) {
                maxLength = fmax(maxLength, 2 * fmin(count0, count1));
                count0 = 0;
                count1 = 0;
            }
            count0++;
        } else {
            count1++;
        }
    }

    if (count1 > 0) {
        maxLength = fmax(maxLength, 2 * fmin(count0, count1));
    }

    return maxLength;
}