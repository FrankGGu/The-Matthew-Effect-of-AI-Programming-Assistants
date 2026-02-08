int minOperations(char* s) {
    int count1 = 0, count2 = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        if (s[i] - '0' != i % 2) {
            count1++;
        } else {
            count2++;
        }
    }

    return count1 < count2 ? count1 : count2;
}