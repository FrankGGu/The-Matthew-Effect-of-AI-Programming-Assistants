#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minInteger(char* num, int k) {
    int n = strlen(num);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int* pos = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        pos[i] = i;
    }

    for (int i = 0; i < n && k > 0; i++) {
        int min_pos = i;
        for (int j = i + 1; j < n && j - i <= k; j++) {
            if (num[pos[j]] < num[pos[min_pos]]) {
                min_pos = j;
            }
        }
        if (min_pos != i) {
            k -= (min_pos - i);
            result[i] = num[pos[min_pos]];
            for (int j = min_pos; j > i; j--) {
                pos[j] = pos[j - 1];
            }
            pos[i] = pos[min_pos + 1];
        } else {
            result[i] = num[pos[i]];
        }
    }

    for (int i = n; i < n; i++) {
        result[i] = '\0';
    }

    return result;
}