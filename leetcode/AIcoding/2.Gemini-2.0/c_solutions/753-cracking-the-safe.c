#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * crackSafe(int n, int k) {
    int total = 1;
    for (int i = 0; i < n; i++) {
        total *= k;
    }

    char *result = (char *)malloc((total + n - 1 + 1) * sizeof(char));
    result[0] = '\0';

    char *visited = (char *)malloc(total * sizeof(char));
    memset(visited, 0, total * sizeof(char));

    char *start = (char *)malloc(n * sizeof(char));
    memset(start, '0', n * sizeof(char));
    start[n] = '\0';

    void dfs(char *str, int len, int n, int k, char *res, char *vis) {
        if (strlen(res) == total + n - 1) {
            return;
        }

        char prefix[n];
        strncpy(prefix, str + len - n + 1, n - 1);
        prefix[n - 1] = '\0';

        for (int i = k - 1; i >= 0; i--) {
            char next[n];
            strcpy(next, prefix);
            next[n - 1] = i + '0';
            next[n] = '\0';

            int val = 0;
            for (int j = 0; j < n; j++) {
                val = val * k + (next[j] - '0');
            }

            if (!vis[val]) {
                vis[val] = 1;
                strcat(res, (char[]){i + '0', '\0'});
                dfs(strcat(str, (char[]){i + '0', '\0'}), strlen(str), n, k, res, vis);
                if (strlen(res) == total + n - 1) {
                    return;
                }
                str[strlen(str) - 1] = '\0';
                res[strlen(res) - 1] = '\0';
                vis[val] = 0;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        strcat(result, "0");
    }
    visited[0] = 1;
    dfs(result, strlen(result), n, k, result, visited);

    free(visited);
    free(start);
    return result;
}