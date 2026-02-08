#include <stdlib.h>
#include <string.h>

char * sortString(char * s){
    int counts[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        counts[s[i] - 'a']++;
    }

    char *result = (char *)malloc(sizeof(char) * (len + 1));
    if (result == NULL) {
        return NULL; 
    }

    int current_len = 0;

    while (current_len < len) {
        // Ascending pass
        for (int i = 0; i < 26; i++) {
            if (counts[i] > 0) {
                result[current_len++] = (char)('a' + i);
                counts[i]--;
            }
        }

        // Descending pass
        for (int i = 25; i >= 0; i--) {
            if (counts[i] > 0) {
                result[current_len++] = (char)('a' + i);
                counts[i]--;
            }
        }
    }

    result[len] = '\0';

    return result;
}