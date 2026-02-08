#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int numberOfValidMoveCombinations(int* positions, int positionsSize) {
    int result = 0;
    int n = positionsSize;
    int* path = (int*)malloc(n * sizeof(int));
    bool* used = (bool*)malloc(n * sizeof(bool));

    void backtrack(int depth) {
        if (depth == n) {
            result++;
            return;
        }
        for (int i = 0; i < n; i++) {
            if (!used[i]) {
                int x1 = positions[i] / 8;
                int y1 = positions[i] % 8;
                bool valid = true;
                for (int j = 0; j < depth; j++) {
                    int x2 = positions[path[j]] / 8;
                    int y2 = positions[path[j]] % 8;
                    int dx = abs(x1 - x2);
                    int dy = abs(y1 - y2);
                    if ((dx == 2 && dy == 1) || (dx == 1 && dy == 2)) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    used[i] = true;
                    path[depth] = i;
                    backtrack(depth + 1);
                    used[i] = false;
                }
            }
        }
    }

    backtrack(0);
    free(path);
    free(used);
    return result;
}