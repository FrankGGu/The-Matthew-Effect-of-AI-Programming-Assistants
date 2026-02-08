#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long strToLong(char *s, int start, int end) {
    long long num = 0;
    for (int i = start; i <= end; i++) {
        num = num * 10 + (s[i] - '0');
    }
    return num;
}

bool isValid(char *num, int start, int len1, int len2) {
    int len = strlen(num);
    if (start + len1 + len2 > len) {
        return false;
    }
    if (len1 > 1 && num[start] == '0') {
        return false;
    }
    if (len2 > 1 && num[start + len1] == '0') {
        return false;
    }
    long long num1 = strToLong(num, start, start + len1 - 1);
    long long num2 = strToLong(num, start + len1, start + len1 + len2 - 1);
    int nextStart = start + len1 + len2;
    while (nextStart < len) {
        long long sum = num1 + num2;
        char sumStr[40];
        sprintf(sumStr, "%lld", sum);
        int sumLen = strlen(sumStr);
        if (nextStart + sumLen > len || strncmp(num + nextStart, sumStr, sumLen) != 0) {
            return false;
        }
        num1 = num2;
        num2 = sum;
        nextStart += sumLen;
    }
    return true;
}

bool isAdditiveNumber(char * num){
    int len = strlen(num);
    for (int i = 1; i <= len / 2; i++) {
        for (int j = 1; j <= (len - i) / 2; j++) {
            if (isValid(num, 0, i, j)) {
                return true;
            }
        }
    }
    return false;
}