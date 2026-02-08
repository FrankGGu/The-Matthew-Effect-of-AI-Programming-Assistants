int minMovesToMakePalindrome(char *s) {
    int n = strlen(s);
    int left = 0, right = n - 1, moves = 0;

    while (left < right) {
        int l = left, r = right;
        while (l < r && s[l] != s[r]) r--;

        if (l == r) {
            moves += n % 2 == 0 ? 1 : 0;
            moves += (n % 2 == 1) ? 1 : 0;
            l = left; r = right;
            while (l < r && s[l] != s[r]) l++;
            moves++;
        } else {
            moves += (right - r);
        }

        left++;
        right--;
    }

    return moves;
}