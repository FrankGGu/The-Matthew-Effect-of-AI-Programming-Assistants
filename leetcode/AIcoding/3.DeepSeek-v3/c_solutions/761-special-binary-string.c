#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return strcmp(*(const char**)b, *(const char**)a);
}

char* makeLargestSpecial(char* s) {
    int n = strlen(s);
    if (n == 0) return "";

    int count = 0;
    int start = 0;
    char** subs = (char**)malloc(n * sizeof(char*));
    int subs_size = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            count++;
        } else {
            count--;
        }

        if (count == 0) {
            int len = i - start + 1;
            char* sub = (char*)malloc((len + 1) * sizeof(char));
            strncpy(sub, s + start, len);
            sub[len] = '\0';

            sub[0] = '1';
            sub[len - 1] = '0';
            char* inner = makeLargestSpecial(sub + 1);
            inner[len - 2] = '\0';

            char* new_sub = (char*)malloc((len + 1) * sizeof(char));
            new_sub[0] = '1';
            strcpy(new_sub + 1, inner);
            new_sub[len - 1] = '0';
            new_sub[len] = '\0';

            subs[subs_size++] = new_sub;
            free(sub);
            free(inner);
            start = i + 1;
        }
    }

    qsort(subs, subs_size, sizeof(char*), cmp);

    char* result = (char*)malloc((n + 1) * sizeof(char));
    int pos = 0;
    for (int i = 0; i < subs_size; i++) {
        int len = strlen(subs[i]);
        strcpy(result + pos, subs[i]);
        pos += len;
        free(subs[i]);
    }
    result[pos] = '\0';
    free(subs);

    return result;
}