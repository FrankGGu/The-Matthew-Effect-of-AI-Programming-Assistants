int balancedString(char * s) {
    int count[4] = {0}, n = strlen(s), target = n / 4, minLength = n + 1;
    for (int i = 0; i < n; i++) {
        count[s[i] - 'A']++;
    }

    if (count[0] <= target && count[1] <= target && count[2] <= target && count[3] <= target) {
        return 0;
    }

    int left = 0, right = 0;
    while (right < n) {
        count[s[right] - 'A']--;
        while (count[0] <= target && count[1] <= target && count[2] <= target && count[3] <= target) {
            minLength = fmin(minLength, right - left + 1);
            count[s[left] - 'A']++;
            left++;
        }
        right++;
    }

    return minLength;
}