#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minMoves(int grid[][100], int m, int n) {
    int students[m * n], obstacles[m * n], empty[m * n];
    int studentCount = 0, obstacleCount = 0, emptyCount = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                students[studentCount++] = i * n + j;
            } else if (grid[i][j] == 2) {
                obstacles[obstacleCount++] = i * n + j;
            } else {
                empty[emptyCount++] = i * n + j;
            }
        }
    }

    int minMoves = 1e9;

    int p[studentCount];
    for (int i = 0; i < studentCount; i++) {
        p[i] = i;
    }

    function(p, studentCount, &minMoves, students, empty, emptyCount, n);

    return minMoves;
}

void function(int p[], int k, int *minMoves, int students[], int empty[], int emptyCount, int n) {
    if (k == 1) {
        int moves = 0;
        for (int i = 0; i < sizeof(p) / sizeof(p[0]); i++) {
            int student_row = students[i] / n;
            int student_col = students[i] % n;
            int empty_row = empty[p[i]] / n;
            int empty_col = empty[p[i]] % n;
            moves += abs(student_row - empty_row) + abs(student_col - empty_col);
        }
        if (moves < *minMoves) {
            *minMoves = moves;
        }
        return;
    }

    for (int i = 0; i < k; i++) {
        swap(&p[i], &p[k - 1]);
        function(p, k - 1, minMoves, students, empty, emptyCount, n);
        swap(&p[i], &p[k - 1]);
    }
}

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}