#include <limits.h>

int nextGreaterElement(int n) {
    char digits[20];
    int len = 0;
    int temp = n;

    while (temp > 0) {
        digits[len++] = temp % 10 + '0';
        temp /= 10;
    }

    for (int i = 0; i < len / 2; i++) {
        char tmp = digits[i];
        digits[i] = digits[len - 1 - i];
        digits[len - 1 - i] = tmp;
    }

    int i = len - 2;
    while (i >= 0 && digits[i] >= digits[i + 1]) {
        i--;
    }

    if (i < 0) {
        return -1;
    }

    int j = len - 1;
    while (j > i && digits[j] <= digits[i]) {
        j--;
    }

    char tmp = digits[i];
    digits[i] = digits[j];
    digits[j] = tmp;

    for (int left = i + 1, right = len - 1; left < right; left++, right--) {
        tmp = digits[left];
        digits[left] = digits[right];
        digits[right] = tmp;
    }

    long long result = 0;
    for (int k = 0; k < len; k++) {
        result = result * 10 + (digits[k] - '0');
    }

    if (result > INT_MAX) {
        return -1;
    }

    return (int)result;
}