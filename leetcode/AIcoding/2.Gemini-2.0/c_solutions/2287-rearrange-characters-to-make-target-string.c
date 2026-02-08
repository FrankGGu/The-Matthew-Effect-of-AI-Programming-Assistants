#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rearrangeCharacters(char * s, char * target){
    int s_freq[26] = {0};
    int target_freq[26] = {0};
    int s_len = strlen(s);
    int target_len = strlen(target);

    for (int i = 0; i < s_len; i++) {
        s_freq[s[i] - 'a']++;
    }

    for (int i = 0; i < target_len; i++) {
        target_freq[target[i] - 'a']++;
    }

    int count = -1;
    for (int i = 0; i < 26; i++) {
        if (target_freq[i] > 0) {
            if (s_freq[i] == 0) {
                return 0;
            }
            int current_count = s_freq[i] / target_freq[i];
            if (count == -1 || current_count < count) {
                count = current_count;
            }
        }
    }

    return count;
}