#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *originalDigits(char *s) {
    int count[26] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        count[s[i] - 'a']++;
    }

    int digits[10] = {0};
    digits[0] = count['z' - 'a'];
    digits[2] = count['w' - 'a'];
    digits[4] = count['u' - 'a'];
    digits[6] = count['x' - 'a'];
    digits[8] = count['g' - 'a'];

    digits[1] = count['o' - 'a'] - digits[0] - digits[2] - digits[4];
    digits[3] = count['h' - 'a'] - digits[8];
    digits[5] = count['f' - 'a'] - digits[4];
    digits[7] = count['v' - 'a'] - digits[5];
    digits[9] = count['i' - 'a'] - digits[5] - digits[6] - digits[8];

    int len = 0;
    for (int i = 0; i < 10; i++) {
        len += digits[i];
    }

    char *result = (char *)malloc(len + 1);
    int index = 0;
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < digits[i]; j++) {
            result[index++] = i + '0';
        }
    }
    result[index] = '\0';

    for (int i = 0; i < len - 1; i++) {
        for (int j = i + 1; j < len; j++) {
            if (result[i] > result[j]) {
                char temp = result[i];
                result[i] = result[j];
                result[j] = temp;
            }
        }
    }

    return result;
}