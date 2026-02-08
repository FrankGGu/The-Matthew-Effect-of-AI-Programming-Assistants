#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findLexSmallestString(char* s, int a, int b) {
    int n = strlen(s);
    char* res = (char*)malloc((n + 1) * sizeof(char));
    strcpy(res, s);

    char* q = (char*)malloc((n + 1) * sizeof(char));
    strcpy(q, s);

    char* visited = (char*)malloc(n * n * sizeof(char));
    memset(visited, 0, n * n * sizeof(char));

    int head = 0, tail = 0;
    char** queue = (char**)malloc(n * n * sizeof(char*));
    for (int i = 0; i < n * n; ++i) {
        queue[i] = (char*)malloc((n + 1) * sizeof(char));
    }

    strcpy(queue[tail++], q);
    visited[0] = 1;

    while (head < tail) {
        char* curr = queue[head++];

        if (strcmp(curr, res) < 0) {
            strcpy(res, curr);
        }

        char* add_res = (char*)malloc((n + 1) * sizeof(char));
        strcpy(add_res, curr);
        for (int i = 1; i < n; i += 2) {
            add_res[i] = (add_res[i] - '0' + a) % 10 + '0';
        }

        int add_idx = 0;
        for (int i = 0; i < n; ++i) {
            add_idx = add_idx * 10 + (add_res[i] - '0');
        }

        if (!visited[add_idx]) {
            visited[add_idx] = 1;
            strcpy(queue[tail++], add_res);
        }

        char* rotate_res = (char*)malloc((n + 1) * sizeof(char));
        strcpy(rotate_res, curr);
        for (int i = 0; i < n; ++i) {
            rotate_res[i] = curr[(i - b + n) % n];
        }

        int rotate_idx = 0;
        for (int i = 0; i < n; ++i) {
            rotate_idx = rotate_idx * 10 + (rotate_res[i] - '0');
        }

        if (!visited[rotate_idx]) {
            visited[rotate_idx] = 1;
            strcpy(queue[tail++], rotate_res);
        }
    }

    for (int i = 0; i < n * n; ++i) {
        free(queue[i]);
    }
    free(queue);
    free(q);
    free(visited);

    return res;
}