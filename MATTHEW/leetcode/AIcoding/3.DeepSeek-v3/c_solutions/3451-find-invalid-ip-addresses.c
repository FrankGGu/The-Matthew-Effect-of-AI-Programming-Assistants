/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** findInvalidIPAddresses(char* s, int* returnSize) {
    int len = strlen(s);
    if (len < 4 || len > 12) {
        *returnSize = 0;
        return NULL;
    }

    char** result = malloc(1000 * sizeof(char*));
    *returnSize = 0;

    for (int i = 1; i <= 3 && i < len; i++) {
        for (int j = i + 1; j <= i + 3 && j < len; j++) {
            for (int k = j + 1; k <= j + 3 && k < len; k++) {
                char part1[4] = {0}, part2[4] = {0}, part3[4] = {0}, part4[4] = {0};

                strncpy(part1, s, i);
                strncpy(part2, s + i, j - i);
                strncpy(part3, s + j, k - j);
                strncpy(part4, s + k, len - k);

                if (strlen(part4) == 0 || strlen(part4) > 3) continue;

                int valid = 1;

                if (atoi(part1) > 255 || (part1[0] == '0' && strlen(part1) > 1)) valid = 0;
                if (atoi(part2) > 255 || (part2[0] == '0' && strlen(part2) > 1)) valid = 0;
                if (atoi(part3) > 255 || (part3[0] == '0' && strlen(part3) > 1)) valid = 0;
                if (atoi(part4) > 255 || (part4[0] == '0' && strlen(part4) > 1)) valid = 0;

                if (!valid) {
                    char* ip = malloc(16 * sizeof(char));
                    sprintf(ip, "%s.%s.%s.%s", part1, part2, part3, part4);
                    result[*returnSize] = ip;
                    (*returnSize)++;
                }
            }
        }
    }

    return result;
}