#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * orderlyQueue(char * s, int k){
    int n = strlen(s);
    if(k > 1){
        qsort(s, n, sizeof(char), (int (*)(const void *, const void *))strcmp);
        return s;
    }

    char *ans = (char*)malloc(sizeof(char) * (n + 1));
    strcpy(ans, s);

    char *temp = (char*)malloc(sizeof(char) * (n + 1));

    for(int i = 1; i < n; i++){
        strncpy(temp, s + i, n - i);
        strncpy(temp + (n - i), s, i);
        temp[n] = '\0';

        if(strcmp(temp, ans) < 0){
            strcpy(ans, temp);
        }
    }

    free(temp);
    return ans;
}