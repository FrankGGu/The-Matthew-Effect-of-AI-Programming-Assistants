#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * removeOccurrences(char * s, char * part){
    int s_len = strlen(s);
    int part_len = strlen(part);

    while (strstr(s, part) != NULL) {
        char *occurrence = strstr(s, part);
        int index = occurrence - s;

        for (int i = index; i < s_len - part_len; i++) {
            s[i] = s[i + part_len];
        }
        s_len -= part_len;
        s[s_len] = '\0';
    }

    return s;
}