char *breakPalindrome(char *palindrome) {
    int len = strlen(palindrome);
    if (len <= 1) return "";

    for (int i = 0; i < len; i++) {
        if (palindrome[i] != 'a') {
            palindrome[i] = 'a';
            return palindrome;
        }
    }

    palindrome[len - 1] = 'b';
    return palindrome;
}