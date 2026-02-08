#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkInclusion(char * s1, char * s2){
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    if (len1 > len2) {
        return false;
    }

    int s1_freq[26] = {0};
    int s2_freq[26] = {0};

    for (int i = 0; i < len1; i++) {
        s1_freq[s1[i] - 'a']++;
        s2_freq[s2[i] - 'a']++;
    }

    for (int i = 0; i <= len2 - len1; i++) {
        bool match = true;
        for (int j = 0; j < 26; j++) {
            if (s1_freq[j] != s2_freq[j]) {
                match = false;
                break;
            }
        }
        if (match) {
            return true;
        }

        if (i < len2 - len1) {
            s2_freq[s2[i] - 'a']--;
            s2_freq[s2[i + len1] - 'a']++;
        }
    }

    return false;
}