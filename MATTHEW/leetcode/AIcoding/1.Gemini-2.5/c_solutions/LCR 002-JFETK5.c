#include <string.h>
#include <stdlib.h>

char *addBinary(char *a, char *b) {
    int len_a = strlen(a);
    int len_b = strlen(b);

    int max_len = (len_a > len_b ? len_a : len_b);

    char *result = (char *)malloc(max_len + 2);
    if (result == NULL) {
        return NULL;
    }

    result[max_len + 1] = '\0';

    int i = len_a - 1;
    int j = len_b - 1;
    int k = max_len;
    int carry = 0;

    while (i >= 0 || j >= 0 || carry > 0) {
        int digitA = (i >= 0) ? a[i] - '0' : 0;
        int digitB = (j >= 0) ? b[j] - '0' : 0;

        int sum = digitA + digitB + carry;

        result[k--] = (sum % 2) + '0';

        carry = sum / 2;

        i--;
        j--;
    }

    return result + k + 1;
}