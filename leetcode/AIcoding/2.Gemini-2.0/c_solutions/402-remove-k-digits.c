#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * removeKdigits(char * num, int k){
    int len = strlen(num);
    if (k == len) {
        char *res = (char *)malloc(sizeof(char) * 2);
        res[0] = '0';
        res[1] = '\0';
        return res;
    }

    char *stack = (char *)malloc(sizeof(char) * (len + 1));
    int top = 0;

    for (int i = 0; i < len; i++) {
        while (top > 0 && stack[top - 1] > num[i] && k > 0) {
            top--;
            k--;
        }
        stack[top++] = num[i];
    }

    while (k > 0) {
        top--;
        k--;
    }

    stack[top] = '\0';

    int start = 0;
    while (start < top - 1 && stack[start] == '0') {
        start++;
    }

    char *result = (char *)malloc(sizeof(char) * (top - start + 1));
    int j = 0;
    for (int i = start; i < top; i++) {
        result[j++] = stack[i];
    }
    result[j] = '\0';

    free(stack);

    if (strlen(result) == 0) {
        char *res = (char *)malloc(sizeof(char) * 2);
        res[0] = '0';
        res[1] = '\0';
        return res;
    }

    return result;
}