#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkStrings(char *s1, char *s2) {
    int len = strlen(s1);
    int odd1[26] = {0};
    int even1[26] = {0};
    int odd2[26] = {0};
    int even2[26] = {0};

    for (int i = 0; i < len; i++) {
        if (i % 2 == 0) {
            even1[s1[i] - 'a']++;
            even2[s2[i] - 'a']++;
        } else {
            odd1[s1[i] - 'a']++;
            odd2[s2[i] - 'a']++;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (odd1[i] != odd2[i] || even1[i] != even2[i]) {
            return false;
        }
    }

    return true;
}