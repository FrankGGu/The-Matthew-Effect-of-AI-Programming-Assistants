bool makeStringsEqual(char* s, char* target) {
    int count1 = 0, count2 = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '1') count1++;
        if (target[i] == '1') count2++;
    }
    if (count1 == 0) return count2 == 0;
    return count2 > 0;
}