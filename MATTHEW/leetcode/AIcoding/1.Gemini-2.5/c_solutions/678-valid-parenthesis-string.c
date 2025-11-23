#include <stdbool.h>

bool checkValidString(char * s) {
    int low = 0;
    int high = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        char c = s[i];
        if (c == '(') {
            low++;
            high++;
        } else if (c == ')') {
            low = (low > 0) ? low - 1 : 0;
            high--;
        } else { // c == '*'
            low = (low > 0) ? low - 1 : 0;
            high++;
        }

        if (high < 0) {
            return false;
        }
    }

    return low == 0;
}