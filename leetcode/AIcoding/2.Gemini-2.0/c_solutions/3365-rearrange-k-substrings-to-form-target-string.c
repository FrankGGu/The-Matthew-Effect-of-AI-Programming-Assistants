#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canRearrange(char * s, int k, char * target) {
    int s_freq[26] = {0};
    int target_freq[26] = {0};

    for (int i = 0; s[i] != '\0'; i++) {
        s_freq[s[i] - 'a']++;
    }

    for (int i = 0; target[i] != '\0'; i++) {
        target_freq[target[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (target_freq[i] > 0 && s_freq[i] < target_freq[i]) {
            return false;
        }
    }

    int n = strlen(target);
    if (n % k != 0) {
        return false;
    }

    for (int i = 0; i < 26; i++) {
        if (target_freq[i] > 0 && target_freq[i] % k != 0) {
            return false;
        }
    }

    return true;
}