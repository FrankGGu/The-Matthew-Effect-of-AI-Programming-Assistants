#include <string.h>
#include <limits.h>

int rearrangeCharacters(char * s, char * target){
    int s_freq[26] = {0};
    int target_freq[26] = {0};

    int len_s = strlen(s);
    for (int i = 0; i < len_s; i++) {
        s_freq[s[i] - 'a']++;
    }

    int len_target = strlen(target);
    for (int i = 0; i < len_target; i++) {
        target_freq[target[i] - 'a']++;
    }

    int ans = INT_MAX;

    for (int i = 0; i < 26; i++) {
        if (target_freq[i] > 0) {
            int current_limit = s_freq[i] / target_freq[i];
            if (current_limit < ans) {
                ans = current_limit;
            }
        }
    }

    return ans;
}