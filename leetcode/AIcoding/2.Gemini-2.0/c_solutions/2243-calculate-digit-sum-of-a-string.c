#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *digitSum(char *s, int k) {
    int len = strlen(s);
    while (len > k) {
        char *next_s = (char *)malloc(sizeof(char) * (len / k + (len % k == 0 ? 0 : 1) + 1));
        int next_len = 0;
        for (int i = 0; i < len; i += k) {
            int sum = 0;
            for (int j = i; j < i + k && j < len; j++) {
                sum += (s[j] - '0');
            }
            sprintf(next_s + next_len, "%d", sum);
            next_len += snprintf(NULL, 0, "%d", sum);
        }
        next_s[next_len] = '\0';
        free(s);
        s = next_s;
        len = next_len;
    }
    return s;
}