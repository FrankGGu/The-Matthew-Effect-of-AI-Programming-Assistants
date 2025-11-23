#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getMaxRepetitions(char *s1, int n1, char *s2, int n2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    int repeat_count = 0;
    int j = 0;

    int *next_index = (int *)malloc(sizeof(int) * len1);
    int *count = (int *)malloc(sizeof(int) * len1);

    memset(next_index, 0, sizeof(int) * len1);
    memset(count, 0, sizeof(int) * len1);

    for (int start = 0; start < len1; start++) {
        int current_j = j;
        int current_count = repeat_count;

        for (int k = start; k < len1; k++) {
            if (s1[k] == s2[j]) {
                j++;
                if (j == len2) {
                    j = 0;
                    repeat_count++;
                }
            }
        }

        next_index[start] = j;
        count[start] = repeat_count - current_count;
        j = current_j;
        repeat_count = current_count;

        for (int l = 0; l < start; l++) {
            if (next_index[l] == j) {
                int prefix_count = repeat_count;
                int pattern_count = (n1 - 1 - start) / (start - l) * (repeat_count - count[l]);
                int suffix_count = 0;
                int remaining = (n1 - 1 - start) % (start - l);

                for (int m = 0; m < remaining; m++) {
                    suffix_count += count[l + m];
                }

                free(next_index);
                free(count);

                return (prefix_count + pattern_count + suffix_count) / n2;
            }
        }
    }

    int total_count = 0;
    for (int i = 0; i < n1; i++) {
        for (int k = 0; k < len1; k++) {
            if (s1[k] == s2[j]) {
                j++;
                if (j == len2) {
                    j = 0;
                    total_count++;
                }
            }
        }
    }

    free(next_index);
    free(count);

    return total_count / n2;
}