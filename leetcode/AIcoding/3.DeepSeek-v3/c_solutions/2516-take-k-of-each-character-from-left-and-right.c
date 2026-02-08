int takeCharacters(char* s, int k) {
    int n = strlen(s);
    int count[3] = {0};
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    if (count[0] < k || count[1] < k || count[2] < k) {
        return -1;
    }

    int left[3] = {0};
    int right[3] = {0};
    int j = n;
    while (right[0] < k || right[1] < k || right[2] < k) {
        j--;
        right[s[j] - 'a']++;
    }

    int res = n - j;

    for (int i = 0; i < n; i++) {
        left[s[i] - 'a']++;
        while (j < n && (left[s[j] - 'a'] + right[s[j] - 'a'] > count[s[j] - 'a'] - k)) {
            right[s[j] - 'a']--;
            j++;
        }
        if (left[0] >= k && left[1] >= k && left[2] >= k) {
            res = fmin(res, i + 1 + n - j);
        }
    }

    return res;
}