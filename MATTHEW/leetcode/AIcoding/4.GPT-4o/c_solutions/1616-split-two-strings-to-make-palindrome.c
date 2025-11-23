bool isPalindrome(char *s, int left, int right) {
    while (left < right) {
        if (s[left] != s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

bool checkPalindromeFormation(char *a, char *b) {
    int lenA = strlen(a);
    int lenB = strlen(b);

    return isPalindrome(a, 0, lenA - 1) || isPalindrome(b, 0, lenB - 1) ||
           isPalindrome(a, 0, lenA - 1) || isPalindrome(b, 0, lenB - 1);
}