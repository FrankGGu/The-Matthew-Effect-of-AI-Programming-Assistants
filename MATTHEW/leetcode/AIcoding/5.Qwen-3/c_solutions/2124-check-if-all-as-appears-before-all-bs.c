#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkIfAllAAfterB(char *s) {
    int a_seen = 0;
    int b_seen = 0;
    for (int i = 0; i < strlen(s); i++) {
        if (s[i] == 'a') {
            a_seen = 1;
        } else if (s[i] == 'b') {
            b_seen = 1;
        }
        if (b_seen && a_seen) {
            return false;
        }
    }
    return true;
}