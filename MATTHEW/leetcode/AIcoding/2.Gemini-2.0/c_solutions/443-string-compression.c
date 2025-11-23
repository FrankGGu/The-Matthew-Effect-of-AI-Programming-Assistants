#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compress(char* chars, int charsSize) {
    if (charsSize == 0) return 0;

    int index = 0;
    int count = 1;
    int write_index = 0;

    for (int i = 1; i <= charsSize; i++) {
        if (i < charsSize && chars[i] == chars[index]) {
            count++;
        } else {
            chars[write_index++] = chars[index];
            if (count > 1) {
                char count_str[10];
                int len = 0;
                int temp = count;
                while (temp > 0) {
                    count_str[len++] = (temp % 10) + '0';
                    temp /= 10;
                }
                for (int j = len - 1; j >= 0; j--) {
                    chars[write_index++] = count_str[j];
                }
            }
            index = i;
            count = 1;
        }
    }

    return write_index;
}