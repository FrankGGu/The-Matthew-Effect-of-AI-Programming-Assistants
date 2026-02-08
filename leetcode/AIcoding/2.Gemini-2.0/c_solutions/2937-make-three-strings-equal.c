#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve() {
    char s1[101], s2[101], s3[101];
    scanf("%s %s %s", s1, s2, s3);
    int n1 = strlen(s1), n2 = strlen(s2), n3 = strlen(s3);
    int len = 0;
    for (int i = 0; i < n1 && i < n2 && i < n3; i++) {
        if (s1[i] == s2[i] && s2[i] == s3[i]) {
            len++;
        } else {
            break;
        }
    }
    if (len == 0) return 0;
    return n1 - len + n2 - len + n3 - len;
}