#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool areAlmostEqual(char * s1, char * s2){
    int first = -1, second = -1;
    int diff_count = 0;
    for (int i = 0; s1[i] != '\0'; i++) {
        if (s1[i] != s2[i]) {
            diff_count++;
            if (first == -1) {
                first = i;
            } else if (second == -1) {
                second = i;
            }
        }
    }

    if (diff_count == 0) return true;
    if (diff_count == 2 && s1[first] == s2[second] && s1[second] == s2[first]) return true;

    return false;
}