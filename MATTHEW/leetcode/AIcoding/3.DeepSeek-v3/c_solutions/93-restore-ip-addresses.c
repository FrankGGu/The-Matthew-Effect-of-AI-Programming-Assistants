/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** restoreIpAddresses(char * s, int* returnSize){
    int len = strlen(s);
    *returnSize = 0;
    if (len < 4 || len > 12) return NULL;

    char **result = (char **)malloc(1000 * sizeof(char *));
    char *ip = (char *)malloc(16 * sizeof(char));

    for (int a = 1; a <= 3; a++) {
        for (int b = 1; b <= 3; b++) {
            for (int c = 1; c <= 3; c++) {
                int d = len - a - b - c;
                if (d < 1 || d > 3) continue;

                int A = 0, B = 0, C = 0, D = 0;

                // Extract first segment
                char temp = s[a]; s[a] = '\0';
                A = atoi(s);
                s[a] = temp;
                if (A > 255 || (a > 1 && s[0] == '0')) continue;

                // Extract second segment
                temp = s[a+b]; s[a+b] = '\0';
                B = atoi(s + a);
                s[a+b] = temp;
                if (B > 255 || (b > 1 && s[a] == '0')) continue;

                // Extract third segment
                temp = s[a+b+c]; s[a+b+c] = '\0';
                C = atoi(s + a + b);
                s[a+b+c] = temp;
                if (C > 255 || (c > 1 && s[a+b] == '0')) continue;

                // Extract fourth segment
                D = atoi(s + a + b + c);
                if (D > 255 || (d > 1 && s[a+b+c] == '0')) continue;

                // Valid IP found
                sprintf(ip, "%d.%d.%d.%d", A, B, C, D);
                result[*returnSize] = (char *)malloc(16 * sizeof(char));
                strcpy(result[*returnSize], ip);
                (*returnSize)++;
            }
        }
    }

    free(ip);
    return result;
}