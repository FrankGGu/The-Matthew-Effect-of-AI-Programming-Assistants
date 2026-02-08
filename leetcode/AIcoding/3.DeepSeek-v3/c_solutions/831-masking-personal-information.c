#include <string.h>
#include <ctype.h>

char* maskPII(char* s) {
    static char result[100];
    int len = strlen(s);
    int at_pos = -1;
    for (int i = 0; i < len; i++) {
        if (s[i] == '@') {
            at_pos = i;
            break;
        }
    }

    if (at_pos != -1) {
        // Email case
        int idx = 0;
        result[idx++] = tolower(s[0]);
        for (int i = 1; i < 5; i++) result[idx++] = '*';
        result[idx++] = tolower(s[at_pos - 1]);
        result[idx++] = '@';
        for (int i = at_pos + 1; i < len; i++) {
            result[idx++] = tolower(s[i]);
        }
        result[idx] = '\0';
    } else {
        // Phone number case
        char digits[20];
        int digit_count = 0;
        for (int i = 0; i < len; i++) {
            if (isdigit(s[i])) {
                digits[digit_count++] = s[i];
            }
        }

        int idx = 0;
        if (digit_count > 10) {
            result[idx++] = '+';
            for (int i = 0; i < digit_count - 10; i++) {
                result[idx++] = '*';
            }
            result[idx++] = '-';
        }

        result[idx++] = '*';
        result[idx++] = '*';
        result[idx++] = '*';
        result[idx++] = '-';
        result[idx++] = '*';
        result[idx++] = '*';
        result[idx++] = '*';
        result[idx++] = '-';

        for (int i = digit_count - 4; i < digit_count; i++) {
            result[idx++] = digits[i];
        }
        result[idx] = '\0';
    }

    return result;
}