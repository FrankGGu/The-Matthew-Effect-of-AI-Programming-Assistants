#define MAX_IP_PARTS 4
#define MAX_STR_LEN 16

void backtrack(char *s, int start, int parts, char **result, int *returnSize, char *currentIP, int currentIndex) {
    if (parts == MAX_IP_PARTS && start == strlen(s)) {
        result[*returnSize] = malloc(sizeof(char) * (currentIndex + 1));
        strcpy(result[*returnSize], currentIP);
        (*returnSize)++;
        return;
    }
    if (parts >= MAX_IP_PARTS) return;

    for (int len = 1; len <= 3; len++) {
        if (start + len > strlen(s)) break;
        char part[4] = {0};
        strncpy(part, s + start, len);
        int value = atoi(part);
        if ((len > 1 && part[0] == '0') || value > 255) continue;
        int oldIndex = currentIndex;
        if (currentIndex > 0) currentIP[currentIndex++] = '.';
        strcpy(currentIP + currentIndex, part);
        currentIndex += len;
        backtrack(s, start + len, parts + 1, result, returnSize, currentIP, currentIndex);
        currentIndex = oldIndex;
    }
}

char **restoreIpAddresses(char *s, int *returnSize) {
    char **result = malloc(sizeof(char*) * 100);
    *returnSize = 0;
    char currentIP[MAX_STR_LEN] = {0};
    backtrack(s, 0, 0, result, returnSize, currentIP, 0);
    return result;
}