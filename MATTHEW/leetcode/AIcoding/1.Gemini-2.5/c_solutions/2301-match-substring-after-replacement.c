#include <stdbool.h>
#include <string.h>

bool matchReplacement(char * s, char * sub, char ** mappings, int mappingsSize) {
    bool can_replace[26][26] = {false};

    for (int i = 0; i < mappingsSize; i++) {
        char old_char = mappings[i][0];
        char new_char = mappings[i][1];
        can_replace[old_char - 'a'][new_char - 'a'] = true;
    }

    int n = strlen(s);
    int m = strlen(sub);

    if (m > n) {
        return false;
    }

    for (int i = 0; i <= n - m; i++) {
        bool current_match = true;
        for (int j = 0; j < m; j++) {
            char s_char = s[i + j];
            char sub_char = sub[j];

            if (s_char != sub_char) {
                if (!can_replace[s_char - 'a'][sub_char - 'a']) {
                    current_match = false;
                    break;
                }
            }
        }
        if (current_match) {
            return true;
        }
    }

    return false;
}