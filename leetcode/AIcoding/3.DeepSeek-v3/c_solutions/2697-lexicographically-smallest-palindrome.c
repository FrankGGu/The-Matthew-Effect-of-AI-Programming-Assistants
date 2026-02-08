char * makeSmallestPalindrome(char * s){
    int n = strlen(s);
    int left = 0, right = n - 1;

    while (left < right) {
        if (s[left] != s[right]) {
            if (s[left] < s[right]) {
                s[right] = s[left];
            } else {
                s[left] = s[right];
            }
        }
        left++;
        right--;
    }

    return s;
}