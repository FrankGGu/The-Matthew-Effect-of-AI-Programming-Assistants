#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkInclusion(char *s1, char *s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    if (len1 > len2) return false;

    int count1[26] = {0};
    int count2[26] = {0};

    for (int i = 0; i < len1; i++) {
        count1[s1[i] - 'a']++;
    }

    for (int i = 0; i < len1; i++) {
        count2[s2[i] - 'a']++;
    }

    if (memcmp(count1, count2, sizeof(count1)) == 0) return true;

    for (int i = len1; i < len2; i++) {
        count2[s2[i - len1] - 'a']--;
        count2[s2[i] - 'a']++;

        if (memcmp(count1, count2, sizeof(count1)) == 0) return true;
    }

    return false;
}