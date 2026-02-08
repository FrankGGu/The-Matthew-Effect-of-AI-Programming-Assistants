char *smallestPalindromic(char *num) {
    int count[10] = {0};
    int len = strlen(num);
    for (int i = 0; i < len; i++) {
        count[num[i] - '0']++;
    }

    char *result = (char *)malloc(len + 1);
    int idx = 0;
    char odd_char = 0;

    for (int i = 1; i < 10; i++) {
        if (count[i] > 0) {
            if (count[i] % 2 == 1 && odd_char == 0) {
                odd_char = i;
            }
            for (int j = 0; j < count[i] / 2; j++) {
                result[idx++] = i + '0';
            }
        }
    }

    if (idx == 0 && odd_char == 0) return "0";

    char *first_half = (char *)malloc(idx + 1);
    memcpy(first_half, result, idx);
    first_half[idx] = '\0';

    if (odd_char) {
        result[idx++] = odd_char + '0';
    }

    for (int i = idx - 1; i >= 0; i--) {
        result[idx++] = first_half[i];
    }

    result[idx] = '\0';
    free(first_half);
    return result;
}