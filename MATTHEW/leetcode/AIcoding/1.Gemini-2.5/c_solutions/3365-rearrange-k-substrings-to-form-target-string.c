#include <string.h>
#include <limits.h>

int rearrangeCharacters(char * s, char * target){
    int s_freq[26] = {0};
    int target_freq[26] = {0};

    int i = 0;
    while (s[i] != '\0') {
        s_freq[s[i] - 'a']++;
        i++;
    }

    i = 0;
    while (target[i] != '\0') {
        target_freq[target[i] - 'a']++;
        i++;
    }

    int max_copies = INT_MAX;

    for (int j = 0; j < 26; j++) {
        if (target_freq[j] > 0) {
            if (s_freq[j] < target_freq[j]) {
                return 0;
            }
            int current_char_copies = s_freq[j] / target_freq[j];
            if (current_char_copies < max_copies) {
                max_copies = current_char_copies;
            }
        }
    }

    return max_copies;
}