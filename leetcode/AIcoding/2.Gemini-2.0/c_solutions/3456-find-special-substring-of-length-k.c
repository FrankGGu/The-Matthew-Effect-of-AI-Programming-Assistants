#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * findLexSmallestString(char * s, int a, int b){
    int n = strlen(s);
    char * smallest = strdup(s);
    char * original = strdup(s);
    char * rotated = (char *)malloc((n + 1) * sizeof(char));

    for (int i = 0; i < n; i++) {
        char * current = strdup(original);

        if (b % 2 == 0) {
            for (int j = 0; j < 10; j++) {
                char * temp = strdup(current);

                for (int k = 1; k < n; k += 2) {
                    int digit = (temp[k] - '0' + a) % 10;
                    temp[k] = digit + '0';
                }

                if (strcmp(temp, smallest) < 0) {
                    strcpy(smallest, temp);
                }

                free(temp);
            }
        } else {
            for (int j = 0; j < 10; j++) {
                char * temp = strdup(current);

                for (int k = 0; k < n; k += 2) {
                    int digit = (temp[k] - '0' + a) % 10;
                    temp[k] = digit + '0';
                }

                for (int l = 0; l < 10; l++) {
                    char * temp2 = strdup(temp);

                    for (int k = 1; k < n; k += 2) {
                        int digit = (temp2[k] - '0' + a) % 10;
                        temp2[k] = digit + '0';
                    }

                    if (strcmp(temp2, smallest) < 0) {
                        strcpy(smallest, temp2);
                    }

                    free(temp2);
                }

                free(temp);
            }

        }

        for (int j = 0; j < n; j++) {
            rotated[(j + b) % n] = original[j];
        }
        rotated[n] = '\0';

        strcpy(original, rotated);

        if (strcmp(original, smallest) < 0) {
                strcpy(smallest, original);
        }

        free(current);
    }

    free(original);
    free(rotated);
    return smallest;
}