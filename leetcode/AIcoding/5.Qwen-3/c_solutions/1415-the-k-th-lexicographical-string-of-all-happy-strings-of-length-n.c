#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getHappyString(int n, int k) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int count = 0;
    char temp[20];

    void dfs(int depth, char prev, char* path) {
        if (depth == n) {
            count++;
            if (count == k) {
                strcpy(path, temp);
            }
            return;
        }

        for (char c = 'a'; c <= 'c'; c++) {
            if (c != prev) {
                temp[depth] = c;
                dfs(depth + 1, c, path);
                if (count == k) return;
            }
        }
    }

    dfs(0, '\0', result);
    return count >= k ? result : NULL;
}