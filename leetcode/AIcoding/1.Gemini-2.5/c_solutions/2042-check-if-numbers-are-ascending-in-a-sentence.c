#include <stdbool.h>
#include <string.h>
#include <ctype.h>

bool areNumbersAscending(char * s) {
    int prevNum = -1;
    int i = 0;
    int n = strlen(s);

    while (i < n) {
        if (isdigit(s[i])) {
            int currentNum = 0;
            while (i < n && isdigit(s[i])) {
                currentNum = currentNum * 10 + (s[i] - '0');
                i++;
            }
            if (currentNum <= prevNum) {
                return false;
            }
            prevNum = currentNum;
        } else {
            i++;
        }
    }
    return true;
}