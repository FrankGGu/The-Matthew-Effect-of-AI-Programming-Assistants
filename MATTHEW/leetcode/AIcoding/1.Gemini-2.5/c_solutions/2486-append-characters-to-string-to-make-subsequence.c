#include <string.h>

int appendCharacters(char *s, char *t) {
    int s_len = strlen(s);
    int t_len = strlen(t);
    int s_ptr = 0;
    int t_ptr = 0;

    while (s_ptr < s_len && t_ptr < t_len) {
        if (s[s_ptr] == t[t_ptr]) {
            t_ptr++;
        }
        s_ptr++;
    }

    return t_len - t_ptr;
}