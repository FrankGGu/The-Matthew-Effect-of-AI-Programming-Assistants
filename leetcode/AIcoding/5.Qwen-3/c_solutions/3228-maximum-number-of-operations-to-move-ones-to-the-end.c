#include <stdio.h>
#include <stdlib.h>

int maxOperations(char* s) {
    int count = 0;
    int ones = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '1') {
            ones++;
        } else if (ones > 0) {
            count++;
        }
    }
    return count;
}