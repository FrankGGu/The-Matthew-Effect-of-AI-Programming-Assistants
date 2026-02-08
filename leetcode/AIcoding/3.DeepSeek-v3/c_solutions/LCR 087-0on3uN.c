/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** restoreIpAddresses(char* s, int* returnSize) {
    int len = strlen(s);
    if (len < 4 || len > 12) {
        *returnSize = 0;
        return NULL;
    }

    char** result = (char**)malloc(1000 * sizeof(char*));
    *returnSize = 0;

    for (int i = 1; i <= 3; i++) {
        for (int j = 1; j <= 3; j++) {
            for (int k = 1; k <= 3; k++) {
                for (int l = 1; l <= 3; l++) {
                    if (i + j + k + l != len) continue;

                    int a = 0, b = 0, c = 0, d = 0;

                    // Parse first segment
                    char temp = s[i];
                    s[i] = '\0';
                    a = atoi(s);
                    s[i] = temp;
                    if (a > 255 || (i > 1 && s[0] == '0')) continue;

                    // Parse second segment
                    temp = s[i + j];
                    s[i + j] = '\0';
                    b = atoi(s + i);
                    s[i + j] = temp;
                    if (b > 255 || (j > 1 && s[i] == '0')) continue;

                    // Parse third segment
                    temp = s[i + j + k];
                    s[i + j + k] = '\0';
                    c = atoi(s + i + j);
                    s[i + j + k] = temp;
                    if (c > 255 || (k > 1 && s[i + j] == '0')) continue;

                    // Parse fourth segment
                    d = atoi(s + i + j + k);
                    if (d > 255 || (l > 1 && s[i + j + k] == '0')) continue;

                    // Valid IP found
                    char* ip = (char*)malloc((len + 4) * sizeof(char));
                    sprintf(ip, "%d.%d.%d.%d", a, b, c, d);
                    result[(*returnSize)++] = ip;
                }
            }
        }
    }

    return result;
}