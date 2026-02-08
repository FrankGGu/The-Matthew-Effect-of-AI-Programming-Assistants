#include <stdbool.h>
#include <string.h>

bool isMatch(char *s, char *p) {
    int s_len = strlen(s);
    int p_len = strlen(p);

    int s_ptr = 0;
    int p_ptr = 0;
    int star_ptr = -1;
    int s_temp_ptr = -1;

    while (s_ptr < s_len) {
        if (p_ptr < p_len && (p[p_ptr] == '?' || s[s_ptr] == p[p_ptr])) {
            s_ptr++;
            p_ptr++;
        } else if (p_ptr < p_len && p[p_ptr] == '*') {
            star_ptr = p_ptr;
            s_temp_ptr = s_ptr;
            p_ptr++;
        } else if (star_ptr != -1) {
            p_ptr = star_ptr + 1;
            s_temp_ptr++;
            s_ptr = s_temp_ptr;
        } else {
            return false;
        }
    }

    while (p_ptr < p_len && p[p_ptr] == '*') {
        p_ptr++;
    }

    return p_ptr == p_len;
}