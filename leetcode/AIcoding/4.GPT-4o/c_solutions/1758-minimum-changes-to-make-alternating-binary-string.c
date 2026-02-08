int minOperations(char * s) {
    int count1 = 0, count2 = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if ((i % 2 == 0 && s[i] == '1') || (i % 2 == 1 && s[i] == '0')) {
            count1++;
        } else {
            count2++;
        }
    }

    return count1 < count2 ? count1 : count2;
}