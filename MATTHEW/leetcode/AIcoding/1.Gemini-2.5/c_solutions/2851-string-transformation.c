#include <string.h>
#include <stdbool.h>

bool canTransform(char * s, char * t) {
    int len_s = strlen(s);
    int len_t = strlen(t);

    if (len_s != len_t) {
        return false;
    }

    if (strcmp(s, t) == 0) {
        return true;
    }

    int s_to_t_map[26];
    for (int i = 0; i < 26; i++) {
        s_to_t_map[i] = -1;
    }

    bool t_chars_used[26] = {false};

    for (int i = 0; i < len_s; i++) {
        int char_s_idx = s[i] - 'a';
        int char_t_idx = t[i] - 'a';

        if (s_to_t_map[char_s_idx] == -1) {
            s_to_t_map[char_s_idx] = char_t_idx;
        } else if (s_to_t_map[char_s_idx] != char_t_idx) {
            return false;
        }

        t_chars_used[char_t_idx] = true;
    }

    int unique_t_count = 0;
    for (int i = 0; i < 26; i++) {
        if (t_chars_used[i]) {
            unique_t_count++;
        }
    }

    if (unique_t_count == 26) {
        return false;
    }

    return true;
}