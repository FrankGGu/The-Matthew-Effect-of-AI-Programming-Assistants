#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minInteger(char* num, int k) {
    int n = strlen(num);
    char* result = (char*)malloc(sizeof(char) * (n + 1));
    strcpy(result, num);

    for (int i = 0; i < n; i++) {
        int best_pos = i;
        for (int j = i + 1; j < n && j - i <= k; j++) {
            if (result[j] < result[best_pos]) {
                best_pos = j;
            }
        }

        if (best_pos != i) {
            char temp = result[best_pos];
            for (int j = best_pos; j > i; j--) {
                result[j] = result[j - 1];
            }
            result[i] = temp;
            k -= (best_pos - i);
        }
    }

    result[n] = '\0';
    return result;
}