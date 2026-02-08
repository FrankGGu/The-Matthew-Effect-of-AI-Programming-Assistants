int calculateMirrorScore(char* s) {
    int len = strlen(s);
    int score = 0;
    int left = 0;
    int right = len - 1;

    while (left < right) {
        if (s[left] != s[right]) {
            int l = left + 1;
            int r = right - 1;
            while (l < right && r > left) {
                if (s[l] == s[r]) {
                    score += (l - left) + (right - r);
                    break;
                }
                l++;
                r--;
            }
        }
        left++;
        right--;
    }

    return score;
}