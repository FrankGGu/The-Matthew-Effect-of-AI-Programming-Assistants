int removePalindromeSub(char* s) {
    if (s[0] == '\0') return 0;

    int left = 0;
    int right = strlen(s) - 1;

    while (left < right) {
        if (s[left] != s[right]) {
            return 2;
        }
        left++;
        right--;
    }

    return 1;
}