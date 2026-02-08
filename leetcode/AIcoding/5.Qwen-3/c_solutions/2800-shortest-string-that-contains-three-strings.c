#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* shortestString(char* a, char* b, char* c) {
    int len_a = strlen(a);
    int len_b = strlen(b);
    int len_c = strlen(c);

    char* result = (char*)malloc(sizeof(char) * (len_a + len_b + len_c + 1));
    strcpy(result, "");

    char* temp = (char*)malloc(sizeof(char) * (len_a + len_b + len_c + 1));

    void combine(char* x, char* y, char* z) {
        int i, j;
        for (i = 0; i <= strlen(x); i++) {
            int match = 1;
            for (j = 0; j < strlen(y); j++) {
                if (x[i + j] != y[j]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                strcpy(temp, x);
                strcat(temp, &y[strlen(y) - (strlen(x) - i)]);
                break;
            }
        }

        if (!match) {
            strcpy(temp, x);
            strcat(temp, y);
        }

        strcpy(result, temp);
        for (i = 0; i <= strlen(temp); i++) {
            int match2 = 1;
            for (j = 0; j < strlen(z); j++) {
                if (temp[i + j] != z[j]) {
                    match2 = 0;
                    break;
                }
            }
            if (match2) {
                strcpy(result, temp);
                strcat(result, &z[strlen(z) - (strlen(temp) - i)]);
                break;
            }
        }

        if (!match2) {
            strcpy(result, temp);
            strcat(result, z);
        }
    }

    char* candidates[6];
    int count = 0;

    char* perm[] = {a, b, c};
    for (int p = 0; p < 6; p++) {
        char* p1 = perm[p % 3];
        char* p2 = perm[(p + 1) % 3];
        char* p3 = perm[(p + 2) % 3];
        char* t = (char*)malloc(sizeof(char) * (strlen(p1) + strlen(p2) + strlen(p3) + 1));
        strcpy(t, "");
        combine(p1, p2, p3);
        candidates[count++] = strdup(result);
        free(t);
    }

    int min_len = strlen(candidates[0]);
    char* shortest = candidates[0];
    for (int i = 1; i < count; i++) {
        if (strlen(candidates[i]) < min_len) {
            min_len = strlen(candidates[i]);
            shortest = candidates[i];
        }
    }

    for (int i = 0; i < count; i++) {
        free(candidates[i]);
    }

    free(temp);
    return shortest;
}