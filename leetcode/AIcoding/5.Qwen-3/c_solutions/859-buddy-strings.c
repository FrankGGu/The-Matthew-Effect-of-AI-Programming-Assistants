#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int buddyStrings(char* A, char* B) {
    if (strlen(A) != strlen(B)) {
        return 0;
    }

    int diff[26] = {0};
    int count = 0;

    for (int i = 0; i < strlen(A); i++) {
        if (A[i] != B[i]) {
            count++;
            if (count > 2) {
                return 0;
            }
        }
        diff[A[i] - 'a']++;
        diff[B[i] - 'a']--;
    }

    for (int i = 0; i < 26; i++) {
        if (diff[i] != 0) {
            return 0;
        }
    }

    return count == 2;
}