#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int count = 0;

void dfs(char *s, int start, int len, char **visited, int *used) {
    if (start + len > strlen(s)) return;
    char *sub = (char *)malloc((len + 1) * sizeof(char));
    strncpy(sub, s + start, len);
    sub[len] = '\0';
    for (int i = 0; i < strlen(s) - len + 1; i++) {
        if (i != start && strncmp(sub, s + i, len) == 0) {
            int flag = 1;
            for (int j = 0; j < count; j++) {
                if (strcmp(visited[j], sub) == 0) {
                    flag = 0;
                    break;
                }
            }
            if (flag) {
                visited[count++] = sub;
                used[start] = 1;
                used[i] = 1;
            }
            break;
        }
    }
    free(sub);
}

int numEquivDominoPairs(int** dominoes, int dominoesSize, int* dominoesColSize) {
    int map[10][10] = {0};
    int res = 0;
    for (int i = 0; i < dominoesSize; i++) {
        int a = dominoes[i][0], b = dominoes[i][1];
        if (a > b) {
            int t = a;
            a = b;
            b = t;
        }
        map[a][b]++;
    }
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
            int n = map[i][j];
            res += n * (n - 1) / 2;
        }
    }
    return res;
}