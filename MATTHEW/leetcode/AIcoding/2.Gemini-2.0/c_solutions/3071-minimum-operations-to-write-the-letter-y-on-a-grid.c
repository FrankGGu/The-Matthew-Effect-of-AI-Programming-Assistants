#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperationsToWriteY(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int ones = 0, twos = 0, zeros = 0;
    int arr[3] = {0};

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if ((i == j || i + j == n - 1) && i <= n / 2) {
                arr[grid[i][j]]++;
            } else {
                if (grid[i][j] == 1) ones++;
                else if (grid[i][j] == 2) twos++;
                else zeros++;
            }
        }
    }

    int ans = INT_MAX;

    int otherOnes = ones, otherTwos = twos, otherZeros = zeros;

    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (i == j) continue;

            ones = otherOnes;
            twos = otherTwos;
            zeros = otherZeros;

            int yOnes = arr[1], yTwos = arr[2], yZeros = arr[0];

            int current = 0;
            if (i == 0) current += yOnes + yTwos;
            else if (i == 1) current += yZeros + yTwos;
            else current += yZeros + yOnes;

            if (j == 0) current += ones + twos;
            else if (j == 1) current += zeros + twos;
            else current += zeros + ones;

            if (i != 0) current -= zeros;
            if (i != 1) current -= ones;
            if (i != 2) current -= twos;

            if (j != 0) current -= yZeros;
            if (j != 1) current -= yOnes;
            if (j != 2) current -= yTwos;

            if(current < ans){
                ans = current;
            }
        }
    }

    return ans;
}