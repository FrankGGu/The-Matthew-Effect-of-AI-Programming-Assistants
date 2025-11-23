#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * smallestNumber(char * pattern){
    int n = strlen(pattern);
    char *res = (char *)malloc((n + 2) * sizeof(char));
    res[n + 1] = '\0';
    int stack[n + 1];
    int top = -1;
    int num = 1;
    for (int i = 0; i <= n; i++) {
        stack[++top] = num++;
        if (i == n || pattern[i] == 'I') {
            while (top >= 0) {
                res[i - top] = stack[top] + '0';
                top--;
            }
        }
    }
    return res;
}