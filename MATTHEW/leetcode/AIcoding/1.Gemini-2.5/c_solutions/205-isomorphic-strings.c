#include <string.h>
#include <stdbool.h>

bool isIsomorphic(char * s, char * t){
    int char_map_s_to_t[256] = {0};
    int char_map_t_to_s[256] = {0};

    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        unsigned char char_s = (unsigned char)s[i];
        unsigned char char_t = (unsigned char)t[i];

        if (char_map_s_to_t[char_s] == 0) {
            char_map_s_to_t[char_s] = char_t;
        } else {
            if (char_map_s_to_t[char_s] != char_t) {
                return false;
            }
        }

        if (char_map_t_to_s[char_t] == 0) {
            char_map_t_to_s[char_t] = char_s;
        } else {
            if (char_map_t_to_s[char_t] != char_s) {
                return false;
            }
        }
    }

    return true;
}