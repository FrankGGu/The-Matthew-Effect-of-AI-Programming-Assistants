#include <stdlib.h>
#include <string.h>

char * findReplaceString(char * s, int* indices, int indicesSize, char ** sources, int sourcesSize, char ** targets, int targetsSize){
    int s_len = strlen(s);

    int *map = (int *)malloc(s_len * sizeof(int));
    for (int i = 0; i < s_len; i++) {
        map[i] = -1;
    }

    for (int k = 0; k < indicesSize; k++) {
        map[indices[k]] = k;
    }

    char *result = (char *)malloc((s_len + indicesSize * 100 + 1) * sizeof(char));
    int result_idx = 0;

    for (int i = 0; i < s_len; i++) {
        if (map[i] != -1) {
            int k = map[i]; 
            int source_len = strlen(sources[k]);

            if (i + source_len <= s_len && strncmp(&s[i], sources[k], source_len) == 0) {
                strcpy(&result[result_idx], targets[k]);
                result_idx += strlen(targets[k]);
                i += source_len - 1;
            } else {
                result[result_idx++] = s[i];
            }
        } else {
            result[result_idx++] = s[i];
        }
    }

    result[result_idx] = '\0';

    free(map);

    return result;
}