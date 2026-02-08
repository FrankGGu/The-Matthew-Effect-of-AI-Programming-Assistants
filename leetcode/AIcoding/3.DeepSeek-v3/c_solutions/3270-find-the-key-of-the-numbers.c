#include <stdlib.h>
#include <string.h>

int getKey(int num1, int num2, int num3) {
    char str1[6], str2[6], str3[6];
    sprintf(str1, "%d", num1);
    sprintf(str2, "%d", num2);
    sprintf(str3, "%d", num3);

    int len1 = strlen(str1);
    int len2 = strlen(str2);
    int len3 = strlen(str3);
    int max_len = len1 > len2 ? (len1 > len3 ? len1 : len3) : (len2 > len3 ? len2 : len3);

    char result[6] = {0};
    for (int i = 0; i < max_len; i++) {
        char min_digit = '9';
        if (i < len1 && str1[len1 - 1 - i] < min_digit) {
            min_digit = str1[len1 - 1 - i];
        }
        if (i < len2 && str2[len2 - 1 - i] < min_digit) {
            min_digit = str2[len2 - 1 - i];
        }
        if (i < len3 && str3[len3 - 1 - i] < min_digit) {
            min_digit = str3[len3 - 1 - i];
        }
        result[max_len - 1 - i] = min_digit;
    }

    return atoi(result);
}