#include <stdlib.h>
#include <string.h>

bool isValid(char *code) {
    int n = strlen(code);
    if (n < 7 || code[0] != '<' || code[n - 1] != '>') return false;

    int i = 0;
    while (i < n) {
        if (code[i] == '<') {
            int j = i + 1;
            while (j < n && code[j] != '>') j++;
            if (j == n) return false;

            int tagLength = j - i - 1;
            if (tagLength < 1 || tagLength > 9) return false;
            if (!isupper(code[i + 1])) return false;

            for (int k = i + 1; k < j; k++) {
                if (!isalnum(code[k])) return false;
            }

            if (j + 1 < n && code[j + 1] == '<') {
                i = j + 1;
            } else {
                char closingTag[11];
                snprintf(closingTag, sizeof(closingTag), "</%.*s>", tagLength, code + i + 1);

                char *p = strstr(code, closingTag);
                if (p == NULL || p != code + j + 1) return false;

                i = p + strlen(closingTag) - code;
            }
        } else {
            return false;
        }
    }
    return i == n;
}