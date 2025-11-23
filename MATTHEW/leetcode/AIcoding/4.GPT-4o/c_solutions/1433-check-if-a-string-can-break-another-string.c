#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(char *)a - *(char *)b);
}

bool checkIfCanBreak(char *s1, char *s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    char *copy1 = (char *)malloc((len1 + 1) * sizeof(char));
    char *copy2 = (char *)malloc((len2 + 1) * sizeof(char));

    strcpy(copy1, s1);
    strcpy(copy2, s2);

    qsort(copy1, len1, sizeof(char), cmp);
    qsort(copy2, len2, sizeof(char), cmp);

    bool canBreakS1 = true;
    bool canBreakS2 = true;

    for (int i = 0; i < len1; i++) {
        if (copy1[i] < copy2[i]) {
            canBreakS1 = false;
            break;
        }
    }

    for (int i = 0; i < len2; i++) {
        if (copy2[i] < copy1[i]) {
            canBreakS2 = false;
            break;
        }
    }

    free(copy1);
    free(copy2);

    return canBreakS1 || canBreakS2;
}