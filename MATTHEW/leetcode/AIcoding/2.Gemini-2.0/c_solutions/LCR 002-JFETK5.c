#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * addBinary(char * a, char * b){
    int lenA = strlen(a);
    int lenB = strlen(b);
    int maxLen = (lenA > lenB) ? lenA : lenB;
    char *result = (char *)malloc(sizeof(char) * (maxLen + 2));
    int carry = 0;
    int i = lenA - 1, j = lenB - 1, k = 0;

    result[maxLen + 1] = '\0';

    while (i >= 0 || j >= 0 || carry) {
        int sum = carry;
        if (i >= 0) {
            sum += a[i] - '0';
            i--;
        }
        if (j >= 0) {
            sum += b[j] - '0';
            j--;
        }

        result[maxLen - k] = (sum % 2) + '0';
        carry = sum / 2;
        k++;
    }

    if (result[maxLen - k + 1] == '0' && k == maxLen) {
        return strdup(result + maxLen - k + 2);
    } else if (carry > 0) {
        result[maxLen - k] = carry + '0';
        return strdup(result + maxLen - k);
    } else {
        return strdup(result + maxLen - k + 1);
    }
}