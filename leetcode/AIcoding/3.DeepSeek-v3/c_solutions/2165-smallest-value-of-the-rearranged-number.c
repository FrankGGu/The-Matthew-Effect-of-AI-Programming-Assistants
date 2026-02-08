#include <stdlib.h>
#include <string.h>

long long smallestNumber(long long num) {
    if (num == 0) return 0;

    int isNegative = num < 0;
    if (isNegative) num = -num;

    char digits[20];
    sprintf(digits, "%lld", num);
    int len = strlen(digits);

    for (int i = 0; i < len; i++) {
        for (int j = i + 1; j < len; j++) {
            if ((!isNegative && digits[i] > digits[j]) || 
                (isNegative && digits[i] < digits[j])) {
                char temp = digits[i];
                digits[i] = digits[j];
                digits[j] = temp;
            }
        }
    }

    if (!isNegative) {
        int firstNonZero = 0;
        while (firstNonZero < len && digits[firstNonZero] == '0') {
            firstNonZero++;
        }
        if (firstNonZero > 0 && firstNonZero < len) {
            digits[0] = digits[firstNonZero];
            digits[firstNonZero] = '0';
        }
    }

    long long result = 0;
    for (int i = 0; i < len; i++) {
        result = result * 10 + (digits[i] - '0');
    }

    return isNegative ? -result : result;
}