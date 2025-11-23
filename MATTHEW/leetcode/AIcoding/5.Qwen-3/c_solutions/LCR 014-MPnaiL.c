#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkInclusion(char *s1, char *s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    if (len1 > len2) return false;

    int count[26] = {0};
    int window[26] = {0};

    for (int i = 0; i < len1; i++) {
        count[s1[i] - 'a']++;
    }

    for (int i = 0; i < len1; i++) {
        window[s2[i] - 'a']++;
    }

    if (memcmp(count, window, sizeof(count)) == 0) return true;

    for (int i = len1; i < len2; i++) {
        window[s2[i - len1] - 'a']--;
        window[s2[i] - 'a']++;

        if (memcmp(count, window, sizeof(count)) == 0) return true;
    }

    return false;
}