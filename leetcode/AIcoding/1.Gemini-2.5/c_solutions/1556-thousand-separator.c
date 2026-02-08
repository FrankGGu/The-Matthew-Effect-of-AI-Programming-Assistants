#include <stdlib.h>
#include <string.h>

char *thousandSeparator(int n) {
    if (n == 0) {
        char *result = (char *)malloc(sizeof(char) * 2);
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    int temp_n = n;
    int num_digits = 0;
    while (temp_n > 0) {
        temp_n /= 10;
        num_digits++;
    }

    int num_separators = (num_digits - 1) / 3;
    int total_length = num_digits + num_separators;

    char *result = (char *)malloc(sizeof(char) * (total_length + 1));
    result[total_length] = '\0';

    int current_pos = total_length - 1;
    int digit_count_in_group = 0;

    while (n > 0) {
        if (digit_count_in_group == 3) {
            result[current_pos--] = '.';
            digit_count_in_group = 0;
        }
        result[current_pos--] = (n % 10) + '0';
        n /= 10;
        digit_count_in_group++;
    }

    return result;
}