#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int nextGreaterElement(int n) {
    char* num = (char*)malloc(12 * sizeof(char));
    sprintf(num, "%d", n);
    int len = strlen(num);
    int i = len - 1;
    while (i > 0 && num[i - 1] >= num[i]) {
        i--;
    }
    if (i == 0) {
        free(num);
        return -1;
    }
    int j = len - 1;
    while (num[j] <= num[i - 1]) {
        j--;
    }
    char temp = num[i - 1];
    num[i - 1] = num[j];
    num[j] = temp;
    int left = i;
    int right = len - 1;
    while (left < right) {
        temp = num[left];
        num[left++] = num[right];
        num[right--] = temp;
    }
    long result = strtol(num, NULL, 10);
    free(num);
    return result > INT_MAX ? -1 : (int)result;
}