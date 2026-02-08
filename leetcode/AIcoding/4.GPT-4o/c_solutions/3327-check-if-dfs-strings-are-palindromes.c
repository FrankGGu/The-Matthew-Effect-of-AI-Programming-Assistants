bool checkPalindrome(char *s) {
    int n = strlen(s);
    int left = 0, right = n - 1;
    while (left < right) {
        if (s[left] != s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

bool dfs(char **strings, int stringsSize) {
    for (int i = 0; i < stringsSize; i++) {
        if (!checkPalindrome(strings[i])) {
            return false;
        }
    }
    return true;
}