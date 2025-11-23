#include <string.h>
#include <stdbool.h>

bool areAlmostEqual(char * s1, char * s2){
    int n = strlen(s1);
    int diff_count = 0;
    int diff_indices[2];

    for (int i = 0; i < n; i++) {
        if (s1[i] != s2[i]) {
            if (diff_count < 2) {
                diff_indices[diff_count] = i;
            }
            diff_count++;
        }
    }

    if (diff_count == 0) {
        return true;
    } else if (diff_count == 2) {
        if (s1[diff_indices[0]] == s2[diff_indices[1]] &&
            s1[diff_indices[1]] == s2[diff_indices[0]]) {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}