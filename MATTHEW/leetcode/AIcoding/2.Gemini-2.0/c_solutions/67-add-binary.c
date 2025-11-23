#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * addBinary(char * a, char * b){
    int len_a = strlen(a);
    int len_b = strlen(b);
    int max_len = (len_a > len_b) ? len_a : len_b;
    char *result = (char *)malloc(sizeof(char) * (max_len + 2));
    int carry = 0;
    int i = len_a - 1, j = len_b - 1, k = 0;

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
        result[k++] = (sum % 2) + '0';
        carry = sum / 2;
    }

    result[k] = '\0';

    for (int l = 0; l < k / 2; l++) {
        char temp = result[l];
        result[l] = result[k - l - 1];
        result[k - l - 1] = temp;
    }

    return result;
}