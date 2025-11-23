#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findLexSmallestString(char* s, int a, int b) {
    int n = strlen(s);
    char* min_s = strdup(s);
    char* visited = (char*)calloc(n, sizeof(char));
    char* q = (char*)malloc(n + 1);
    int head = 0, tail = 0;

    q[tail++] = 0;
    visited[0] = 1;

    while (head < tail) {
        int curr = q[head++];

        char* current_s = (char*)malloc(n + 1);
        strcpy(current_s, s);
        for (int i = 0; i < n; i++) {
            current_s[i] = s[(i + curr) % n];
        }

        if (strcmp(current_s, min_s) < 0) {
            strcpy(min_s, current_s);
        }
        free(current_s);

        int next_add = curr;
        char* next_s_add = (char*)malloc(n + 1);
        strcpy(next_s_add, s);
        for (int i = 1; i < n; i += 2) {
            next_s_add[i] = ((next_s_add[i] - '0' + a) % 10) + '0';
        }

        int next_add_val = curr;
        for (int i = 0; i < n; i++) {
            s[i] = next_s_add[i];
        }

        int hash_val = next_add;

        if (!visited[hash_val]) {
            q[tail++] = hash_val;
            visited[hash_val] = 1;

            char* current_s2 = (char*)malloc(n + 1);
            strcpy(current_s2, s);
            for (int i = 0; i < n; i++) {
                current_s2[i] = s[(i + hash_val) % n];
            }
            if (strcmp(current_s2, min_s) < 0) {
                strcpy(min_s, current_s2);
            }
            free(current_s2);
        }
        free(next_s_add);

        strcpy(s, min_s);

        int next_rotate = (curr + b) % n;
        if (!visited[next_rotate]) {
            q[tail++] = next_rotate;
            visited[next_rotate] = 1;
        }

        strcpy(s, min_s);
    }

    free(q);
    free(visited);
    return min_s;
}