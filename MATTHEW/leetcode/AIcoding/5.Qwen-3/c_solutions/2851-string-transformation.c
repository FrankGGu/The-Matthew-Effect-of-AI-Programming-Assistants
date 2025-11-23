#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* strTransform(char* s, char* t, int k) {
    int len = strlen(s);
    if (len != strlen(t)) return NULL;

    int* map = (int*)malloc(26 * sizeof(int));
    for (int i = 0; i < 26; i++) map[i] = -1;

    for (int i = 0; i < len; i++) {
        if (map[s[i] - 'a'] == -1) {
            map[s[i] - 'a'] = t[i] - 'a';
        } else if (map[s[i] - 'a'] != t[i] - 'a') {
            free(map);
            return NULL;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (map[i] != -1) {
            int curr = i;
            int next = map[curr];
            int visited[26] = {0};
            while (next != -1 && !visited[next]) {
                visited[next] = 1;
                if (next == curr) {
                    free(map);
                    return NULL;
                }
                next = map[next];
            }
        }
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    for (int i = 0; i < len; i++) {
        result[i] = map[s[i] - 'a'] + 'a';
    }
    result[len] = '\0';
    free(map);
    return result;
}