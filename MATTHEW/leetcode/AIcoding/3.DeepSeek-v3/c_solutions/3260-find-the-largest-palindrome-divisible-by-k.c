char* largestPalindromic(char* num, int k) {
    int count[10] = {0};
    int len = strlen(num);
    for (int i = 0; i < len; i++) {
        count[num[i] - '0']++;
    }

    int half[len + 1];
    int half_len = 0;
    int mid = -1;

    for (int i = 9; i >= 0; i--) {
        if (half_len == 0 && i == 0) continue;
        while (count[i] > 1) {
            half[half_len++] = i;
            count[i] -= 2;
        }
        if (count[i] == 1 && mid == -1) {
            mid = i;
        }
    }

    if (half_len == 0) {
        if (mid != -1) {
            char* res = malloc(2);
            res[0] = mid + '0';
            res[1] = '\0';
            return res;
        } else {
            char* res = malloc(2);
            res[0] = '0';
            res[1] = '\0';
            return res;
        }
    }

    int total_len = half_len * 2 + (mid != -1 ? 1 : 0);
    char* res = malloc(total_len + 1);
    int idx = 0;
    for (int i = 0; i < half_len; i++) {
        res[idx++] = half[i] + '0';
    }
    if (mid != -1) {
        res[idx++] = mid + '0';
    }
    for (int i = half_len - 1; i >= 0; i--) {
        res[idx++] = half[i] + '0';
    }
    res[idx] = '\0';

    return res;
}