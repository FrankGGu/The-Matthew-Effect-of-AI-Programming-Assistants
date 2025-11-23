#include <string.h>

char* removeOccurrences(char* s, char* part) {
    size_t part_len = strlen(part);
    if (part_len == 0) {
        return s;
    }

    char* found_ptr;
    while ((found_ptr = strstr(s, part)) != NULL) {
        size_t s_len_after_part = strlen(found_ptr + part_len);
        memmove(found_ptr, found_ptr + part_len, s_len_after_part + 1);
    }

    return s;
}