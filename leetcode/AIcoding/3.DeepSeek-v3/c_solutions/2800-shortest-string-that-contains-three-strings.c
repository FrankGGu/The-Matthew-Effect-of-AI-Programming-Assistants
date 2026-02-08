#include <string.h>
#include <stdbool.h>

void mergeStrings(char* result, const char* a, const char* b) {
    int lenA = strlen(a);
    int lenB = strlen(b);

    // Check if b is already contained in a
    if (strstr(a, b) != NULL) {
        strcpy(result, a);
        return;
    }

    // Find the maximum overlap where end of a matches start of b
    int overlap = 0;
    for (int i = 1; i <= lenA && i <= lenB; i++) {
        if (strncmp(a + lenA - i, b, i) == 0) {
            overlap = i;
        }
    }

    strcpy(result, a);
    strcpy(result + lenA, b + overlap);
}

char* minimumString(char* a, char* b, char* c) {
    char* strings[3] = {a, b, c};
    char temp[301];
    char result[301];
    strcpy(result, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

    // Try all permutations
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            for (int k = 0; k < 3; k++) {
                if (i == j || j == k || i == k) continue;

                // Merge strings in order i -> j -> k
                mergeStrings(temp, strings[i], strings[j]);
                char temp2[301];
                mergeStrings(temp2, temp, strings[k]);

                int lenRes = strlen(result);
                int lenTemp = strlen(temp2);

                // Update result if temp2 is shorter, or same length but lexicographically smaller
                if (lenTemp < lenRes || (lenTemp == lenRes && strcmp(temp2, result) < 0)) {
                    strcpy(result, temp2);
                }
            }
        }
    }

    return strdup(result);
}