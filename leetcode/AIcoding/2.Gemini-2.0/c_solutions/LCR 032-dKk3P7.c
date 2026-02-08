#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isAnagram(char * s, char * t){
    int len_s = strlen(s);
    int len_t = strlen(t);

    if (len_s != len_t) {
        return false;
    }

    int freq[26] = {0};

    for (int i = 0; i < len_s; i++) {
        freq[s[i] - 'a']++;
        freq[t[i] - 'a']--;
    }

    for (int i = 0; i < 26; i++) {
        if (freq[i] != 0) {
            return false;
        }
    }

    return true;
}