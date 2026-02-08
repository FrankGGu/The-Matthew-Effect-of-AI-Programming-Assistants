#include <string.h>

int minSwaps(char * s){
    int open_brackets = 0;
    int unmatched_closing = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        if (s[i] == '[') {
            open_brackets++;
        } else { // s[i] == ']'
            if (open_brackets > 0) {
                open_brackets--;
            } else {
                unmatched_closing++;
            }
        }
    }

    return (unmatched_closing + 1) / 2;
}