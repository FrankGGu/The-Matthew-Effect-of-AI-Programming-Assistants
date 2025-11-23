#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* crackSafe(int n, int k) {
    if (n == 1) {
        char* result = (char*)malloc(k + 1);
        for (int i = 0; i < k; i++) {
            result[i] = '0' + i;
        }
        result[k] = '\0';
        return result;
    }

    int total = 1;
    for (int i = 0; i < n - 1; i++) {
        total *= k;
    }

    char* result = (char*)malloc(total + n);
    memset(result, '0', n);
    result[n] = '\0';

    int* visited = (int*)calloc(total, sizeof(int));
    int index = n;

    char* temp = (char*)malloc(n * sizeof(char));
    for (int i = 0; i < n; i++) {
        temp[i] = '0';
    }

    int count = 0;

    while (count < total) {
        int last = 0;
        for (int i = 0; i < n - 1; i++) {
            last = last * k + (temp[i] - '0');
        }

        for (int d = 0; d < k; d++) {
            int next = last * k + d;
            if (!visited[next]) {
                visited[next] = 1;
                temp[n - 1] = '0' + d;
                strcpy(result + index, temp);
                index += 1;
                count++;
                break;
            }
        }

        for (int i = n - 1; i > 0; i--) {
            temp[i] = temp[i - 1];
        }
    }

    free(temp);
    free(visited);
    return result;
}