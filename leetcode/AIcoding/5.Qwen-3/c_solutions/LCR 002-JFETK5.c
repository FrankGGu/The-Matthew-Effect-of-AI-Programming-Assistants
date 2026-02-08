#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* addBinary(char* a, char* b) {
    int lenA = strlen(a);
    int lenB = strlen(b);
    int maxLength = lenA > lenB ? lenA : lenB;
    char* result = (char*)malloc((maxLength + 2) * sizeof(char));
    int carry = 0;
    int i = lenA - 1;
    int j = lenB - 1;
    int k = 0;

    while (i >= 0 || j >= 0 || carry > 0) {
        int sum = carry;
        if (i >= 0) sum += a[i] - '0';
        if (j >= 0) sum += b[j] - '0';
        carry = sum / 2;
        result[k++] = '0' + (sum % 2);
        i--;
        j--;
    }

    result[k] = '\0';
    int left = 0;
    int right = k - 1;
    while (left < right) {
        char temp = result[left];
        result[left] = result[right];
        result[right] = temp;
        left++;
        right--;
    }

    return result;
}