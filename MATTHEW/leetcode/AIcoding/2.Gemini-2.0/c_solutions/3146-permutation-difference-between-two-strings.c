#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int permutationDifference(char* s1, char* s2) {
    int n1 = strlen(s1);
    int n2 = strlen(s2);

    if (n1 != n2) {
        return -1;
    }

    int count1[26] = {0};
    int count2[26] = {0};

    for (int i = 0; i < n1; i++) {
        count1[s1[i] - 'a']++;
        count2[s2[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (count1[i] != count2[i]) {
            return -1;
        }
    }

    int diff = 0;
    for (int i = 0; i < n1; i++) {
        if (s1[i] != s2[i]) {
            diff++;
        }
    }

    return diff;
}