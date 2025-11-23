#include <stdbool.h>
#include <stdlib.h>

void backtrack(int k, int n, bool* visited, int* count) {
    if (k > n) {
        (*count)++;
        return;
    }

    for (int num = 1; num <= n; num++) {
        if (!visited[num] && (num % k == 0 || k % num == 0)) {
            visited[num] = true;
            backtrack(k + 1, n, visited, count);
            visited[num] = false; // Backtrack
        }
    }
}

int countArrangement(int n) {
    int count = 0;
    bool* visited = (bool*)calloc(n + 1, sizeof(bool)); // visited[0] is unused

    backtrack(1, n, visited, &count);

    free(visited);
    return count;
}