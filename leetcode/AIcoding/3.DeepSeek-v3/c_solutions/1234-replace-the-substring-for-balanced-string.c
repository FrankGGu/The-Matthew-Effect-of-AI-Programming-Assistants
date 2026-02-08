int balancedString(char* s) {
    int count[4] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (s[i] == 'Q') count[0]++;
        else if (s[i] == 'W') count[1]++;
        else if (s[i] == 'E') count[2]++;
        else if (s[i] == 'R') count[3]++;
    }

    int target = len / 4;
    int left = 0, right = 0;
    int min_len = len;

    while (right <= len) {
        if (count[0] <= target && count[1] <= target && count[2] <= target && count[3] <= target) {
            min_len = (min_len < right - left) ? min_len : right - left;
            if (left < len) {
                if (s[left] == 'Q') count[0]++;
                else if (s[left] == 'W') count[1]++;
                else if (s[left] == 'E') count[2]++;
                else if (s[left] == 'R') count[3]++;
                left++;
            } else {
                break;
            }
        } else {
            if (right < len) {
                if (s[right] == 'Q') count[0]--;
                else if (s[right] == 'W') count[1]--;
                else if (s[right] == 'E') count[2]--;
                else if (s[right] == 'R') count[3]--;
                right++;
            } else {
                break;
            }
        }
    }

    return min_len;
}