#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * maskPII(char * s){
    int n = strlen(s);
    char *res = (char*)malloc(sizeof(char) * 100);
    int i, j;
    if (strchr(s, '@')) {
        for (i = 0; i < n; i++) {
            s[i] = tolower(s[i]);
        }
        char *at = strchr(s, '@');
        int index = at - s;
        res[0] = s[0];
        res[1] = '*';
        res[2] = '*';
        res[3] = '*';
        res[4] = '*';
        res[5] = '*';
        res[6] = s[index - 1];
        res[7] = '@';
        strcpy(res + 8, at + 1);
    } else {
        char digits[11] = "";
        int digit_count = 0;
        for (i = 0; i < n; i++) {
            if (isdigit(s[i])) {
                digits[digit_count++] = s[i];
            }
        }
        char last_four[5];
        strncpy(last_four, digits + digit_count - 4, 4);
        last_four[4] = '\0';
        if (digit_count == 10) {
            sprintf(res, "***-***-%s", last_four);
        } else if (digit_count == 11) {
            sprintf(res, "+*-***-***-%s", last_four);
        } else if (digit_count == 12) {
            sprintf(res, "+**-***-***-%s", last_four);
        } else {
            sprintf(res, "+***-***-***-%s", last_four);
        }
    }
    return res;
}