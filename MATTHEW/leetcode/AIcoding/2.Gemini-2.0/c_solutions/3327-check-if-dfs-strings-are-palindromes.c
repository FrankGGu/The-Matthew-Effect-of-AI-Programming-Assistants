#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPalindrome(char *s) {
    int left = 0;
    int right = strlen(s) - 1;
    while (left < right) {
        if (s[left] != s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

bool solve(int node, int n, char *s, int *visited, char *path, int pathLen, bool *result) {
    if (*result) return true;

    visited[node] = 1;
    path[pathLen++] = s[node];
    path[pathLen] = '\0';

    if (pathLen == n) {
        if (isPalindrome(path)) {
            *result = true;
        }
        visited[node] = 0;
        path[--pathLen] = '\0';
        return *result;
    }

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            if (solve(i, n, s, visited, path, pathLen, result)) {
                visited[node] = 0;
                path[--pathLen] = '\0';
                return true;
            }
        }
    }

    visited[node] = 0;
    path[--pathLen] = '\0';
    return *result;
}

bool checkDFSStringsArePalindromes(char *s) {
    int n = strlen(s);
    int *visited = (int *)malloc(n * sizeof(int));
    char *path = (char *)malloc((n + 1) * sizeof(char));
    bool result = false;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            visited[j] = 0;
        }
        if (solve(i, n, s, visited, path, 0, &result)) {
            free(visited);
            free(path);
            return true;
        }
    }

    free(visited);
    free(path);
    return false;
}