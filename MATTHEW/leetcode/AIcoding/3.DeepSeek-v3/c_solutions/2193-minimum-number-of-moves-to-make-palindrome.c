int minMovesToMakePalindrome(char* s) {
    int n = strlen(s);
    int moves = 0;
    int left = 0, right = n - 1;

    while (left < right) {
        if (s[left] == s[right]) {
            left++;
            right--;
            continue;
        }

        int r = right - 1;
        while (r > left && s[r] != s[left]) {
            r--;
        }

        if (r == left) {
            char temp = s[left];
            s[left] = s[left + 1];
            s[left + 1] = temp;
            moves++;
            continue;
        }

        for (int i = r; i < right; i++) {
            char temp = s[i];
            s[i] = s[i + 1];
            s[i + 1] = temp;
            moves++;
        }

        left++;
        right--;
    }

    return moves;
}