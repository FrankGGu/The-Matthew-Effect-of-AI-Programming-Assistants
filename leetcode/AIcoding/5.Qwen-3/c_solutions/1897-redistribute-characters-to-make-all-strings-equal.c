#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool makeEqual(char** str, int n) {
    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        for (int j = 0; str[i][j]; j++) {
            count[str[i][j] - 'a']++;
        }
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] % n != 0) return false;
    }
    return true;
}