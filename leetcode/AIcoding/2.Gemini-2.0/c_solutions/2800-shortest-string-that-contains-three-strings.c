#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* merge(char* s1, char* s2) {
    int n1 = strlen(s1);
    int n2 = strlen(s2);
    for (int i = 0; i < n1; i++) {
        int j = 0;
        while (i + j < n1 && j < n2 && s1[i + j] == s2[j]) {
            j++;
        }
        if (i + j == n1) {
            char* res = (char*)malloc(sizeof(char) * (n1 + n2 - j + 1));
            strcpy(res, s1);
            strcat(res, s2 + j);
            return res;
        }
    }
    char* res = (char*)malloc(sizeof(char) * (n1 + n2 + 1));
    strcpy(res, s1);
    strcat(res, s2);
    return res;
}

char* shortestSuperstring(char* a, char* b, char* c) {
    char* perm[6][3] = {
        {a, b, c},
        {a, c, b},
        {b, a, c},
        {b, c, a},
        {c, a, b},
        {c, b, a}
    };
    char* ans = NULL;
    int minLen = 1000000;

    for (int i = 0; i < 6; i++) {
        char* s1 = merge(perm[i][0], perm[i][1]);
        char* s = merge(s1, perm[i][2]);
        int len = strlen(s);
        if (len < minLen) {
            minLen = len;
            if (ans != NULL) free(ans);
            ans = s;
        } else {
            free(s);
        }
        free(s1);
    }
    return ans;
}

char * shortestString(char * s1, char * s2, char * s3){
    return shortestSuperstring(s1, s2, s3);
}