#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* diStringMatch(char * s, int* returnSize){
    int n = strlen(s);
    int* result = (int*)malloc(sizeof(int) * (n + 1));
    *returnSize = n + 1;
    int low = 0, high = n;
    for (int i = 0; i < n; i++) {
        if (s[i] == 'I') {
            result[i] = low++;
        } else {
            result[i] = high--;
        }
    }
    result[n] = low;
    return result;
}