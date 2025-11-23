bool validPalindrome(char * s) {
    int left = 0, right = strlen(s) - 1;

    while (left < right) {
        if (s[left] != s[right]) {
            char temp1 = s[left], temp2 = s[right];
            s[left] = s[right] = '\0';
            bool check1 = strcmp(s + left + 1, s + left + 1) == 0;
            s[left] = temp1;
            s[right] = temp2;
            s[right] = '\0';
            bool check2 = strcmp(s, s + right + 1) == 0;
            return check1 || check2;
        }
        left++;
        right--;
    }
    return true;
}