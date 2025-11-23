int longestDecomposition(char * text) {
    int n = strlen(text);
    int left = 0, right = n - 1;
    int count = 0;

    while (left <= right) {
        int len = 1;
        while (left + len - 1 < right - len + 1) {
            if (strncmp(text + left, text + right - len + 1, len) == 0) {
                count += 2;
                left += len;
                right -= len;
                break;
            }
            len++;
        }
        if (left + len - 1 >= right - len + 1) {
            if (left <= right) {
                count++;
            }
            break;
        }
    }

    return count;
}