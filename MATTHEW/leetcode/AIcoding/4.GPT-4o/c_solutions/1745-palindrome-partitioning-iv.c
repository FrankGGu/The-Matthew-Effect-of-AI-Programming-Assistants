bool isPalindrome(char *s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) return false;
        start++;
        end--;
    }
    return true;
}

bool checkPartitioning(char *s) {
    int len = strlen(s);
    for (int i = 1; i < len - 1; i++) {
        for (int j = i + 1; j < len; j++) {
            if (isPalindrome(s, 0, i - 1) && isPalindrome(s, i, j - 1) && isPalindrome(s, j, len - 1)) {
                return true;
            }
        }
    }
    return false;
}