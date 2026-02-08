#include <stdbool.h>
#include <stdlib.h>
#include <math.h>

static int g_count;
static bool* g_visited;
static int* g_A;
static int g_N;

int compare(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

bool isPerfectSquare(int num) {
    if (num < 0) return false;
    int root = (int)sqrt(num);
    return root * root == num;
}

void backtrack(int index, int prev_val) {
    if (index == g_N) {
        g_count++;
        return;
    }

    for (int i = 0; i < g_N; i++) {
        if (g_visited[i]) {
            continue;
        }

        if (i > 0 && g_A[i] == g_A[i-1] && !g_visited[i-1]) {
            continue;
        }

        if (index == 0 || isPerfectSquare(prev_val + g_A[i])) {
            g_visited[i] = true;
            backtrack(index + 1, g_A[i]);
            g_visited[i] = false;
        }
    }
}

int numSquarefulPerms(int* A, int ASize) {
    g_N = ASize;
    if (g_N == 0) return 0;

    g_count = 0;
    g_A = A;

    g_visited = (bool*)malloc(g_N * sizeof(bool));
    for (int i = 0; i < g_N; ++i) {
        g_visited[i] = false;
    }

    qsort(g_A, g_N, sizeof(int), compare);

    backtrack(0, 0);

    free(g_visited);

    return g_count;
}