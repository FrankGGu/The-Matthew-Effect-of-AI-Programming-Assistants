#include <string.h>
#include <stdlib.h>
#include <ctype.h>

char * maskPI(char * s){
    int len = strlen(s);
    char *result;

    char *at_pos = strchr(s, '@');

    if (at_pos != NULL) {
        // Email masking
        int name_len = at_pos - s;
        // Max length: 1 (first) + 5 (stars) + 1 (last) + 1 (@) + domain_length + 1 (null)
        // Max increase in length for name part is 6 (e.g., 'a' becomes 'a*****a')
        result = (char *)malloc(len + 7); 
        if (result == NULL) return NULL;

        int result_idx = 0;

        result[result_idx++] = tolower(s[0]);

        for (int i = 0; i < 5; i++) {
            result[result_idx++] = '*';
        }

        result[result_idx++] = tolower(s[name_len - 1]);

        result[result_idx++] = '@';

        for (char *p = at_pos + 1; *p != '\0'; p++) {
            result[result_idx++] = tolower(*p);
        }
        result[result_idx] = '\0';

    } else {
        // Phone number masking
        char digits_only[20]; 
        int digit_count = 0;
        for (int i = 0; i < len; i++) {
            if (isdigit(s[i])) {
                digits_only[digit_count++] = s[i];
            }
        }
        digits_only[digit_count] = '\0';

        // Max length: +***-***-***-XXXX (15 chars) + 1 (null)
        result = (char *)malloc(16);
        if (result == NULL) return NULL;

        int result_idx = 0;

        if (digit_count > 10) {
            result[result_idx++] = '+';
            for (int i = 0; i < digit_count - 10; i++) {
                result[result_idx++] = '*';
            }
            result[result_idx++] = '-';
        }

        result[result_idx++] = '*';
        result[result_idx++] = '*';
        result[result_idx++] = '*';
        result[result_idx++] = '-';

        result[result_idx++] = '*';
        result[result_idx++] = '*';
        result[result_idx++] = '*';
        result[result_idx++] = '-';

        result[result_idx++] = digits_only[digit_count - 4];
        result[result_idx++] = digits_only[digit_count - 3];
        result[result_idx++] = digits_only[digit_count - 2];
        result[result_idx++] = digits_only[digit_count - 1];
        result[result_idx] = '\0';
    }

    return result;
}