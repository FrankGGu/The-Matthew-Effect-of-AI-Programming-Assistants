#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxUniqueSplit(char *s) {
    int n = strlen(s);
    int max_count = 0;
    char **set = (char **)malloc(n * sizeof(char *));

    void backtrack(int start, int count) {
        if (start == n) {
            if (count > max_count) max_count = count;
            return;
        }
        for (int i = start; i < n; i++) {
            int len = i - start + 1;
            char *substr = (char *)malloc((len + 1) * sizeof(char));
            strncpy(substr, s + start, len);
            substr[len] = '\0';
            int found = 0;
            for (int j = 0; j < count; j++) {
                if (strcmp(set[j], substr) == 0) {
                    found = 1;
                    break;
                }
            }
            if (!found) {
                set[count] = substr;
                backtrack(i + 1, count + 1);
                free(substr);
            } else {
                free(substr);
            }
        }
    }

    backtrack(0, 0);
    free(set);
    return max_count;
}