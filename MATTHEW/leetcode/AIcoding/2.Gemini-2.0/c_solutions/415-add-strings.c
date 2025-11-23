#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * addStrings(char * num1, char * num2){
    int len1 = strlen(num1);
    int len2 = strlen(num2);
    int maxLen = (len1 > len2) ? len1 : len2;
    char *result = (char*)malloc(sizeof(char) * (maxLen + 2));
    result[maxLen + 1] = '\0';
    int carry = 0;
    int i = len1 - 1, j = len2 - 1, k = maxLen;
    while (i >= 0 || j >= 0 || carry) {
        int digit1 = (i >= 0) ? num1[i] - '0' : 0;
        int digit2 = (j >= 0) ? num2[j] - '0' : 0;
        int sum = digit1 + digit2 + carry;
        carry = sum / 10;
        result[k] = (sum % 10) + '0';
        i--;
        j--;
        k--;
    }
    if (k == 0) {
        return result;
    } else {
        return result + 1;
    }
}