#include <stdlib.h>
#include <string.h>

char* addBinary(char* a, char* b) {
    int len_a = strlen(a);
    int len_b = strlen(b);
    int max_len = (len_a > len_b ? len_a : len_b);
    char* result = (char*)malloc(sizeof(char) * (max_len + 2));
    if (result == NULL) {
        return NULL;
    }
    result[max_len + 1] = '\0';

    int i = len_a - 1;
    int j = len_b - 1;
    int k = max_len;
    int carry = 0;

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

        result[k] = (sum % 2) + '0';
        carry = sum / 2;
        k--;
    }

    if (k == -1) { // Carry resulted in an extra digit at the beginning
        return result;
    } else { // No extra carry, so shift the string to the left
        return result + k + 1;
    }
}