#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSpecialSubsequences(char* s) {
    int a = 0, ab = 0, abc = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == 'a') {
            a = (a + 1) % 1000000007;
        } else if (s[i] == 'b') {
            ab = (ab + a) % 1000000007;
        } else if (s[i] == 'c') {
            abc = (abc + ab) % 1000000007;
        }
    }
    return abc;
}