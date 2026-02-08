int dismantlingAction(char* list) {
    int last[256];
    memset(last, -1, sizeof(last));
    int left = 0, maxLen = 0;

    for (int right = 0; list[right] != '\0'; right++) {
        if (last[list[right]] >= left) {
            left = last[list[right]] + 1;
        }
        last[list[right]] = right;
        int len = right - left + 1;
        if (len > maxLen) {
            maxLen = len;
        }
    }

    return maxLen;
}