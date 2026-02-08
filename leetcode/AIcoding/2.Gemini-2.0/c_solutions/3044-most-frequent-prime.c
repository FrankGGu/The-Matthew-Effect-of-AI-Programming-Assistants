#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 1000

bool isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int mostFrequentPrime(int** mat, int matSize, int* matColSize) {
    int rows = matSize;
    int cols = matColSize[0];
    int freq[MAX_SIZE * MAX_SIZE] = {0};
    int maxFreq = 0;
    int mostFrequent = -1;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            // 8 directions
            int dx[] = {-1, -1, -1, 0, 0, 1, 1, 1};
            int dy[] = {-1, 0, 1, -1, 1, -1, 0, 1};

            for (int k = 0; k < 8; k++) {
                int num = mat[i][j];
                int x = i + dx[k];
                int y = j + dy[k];

                while (x >= 0 && x < rows && y >= 0 && y < cols) {
                    num = num * 10 + mat[x][y];
                    if (num >= 10 && isPrime(num)) {
                        freq[num]++;
                        if (freq[num] > maxFreq) {
                            maxFreq = freq[num];
                            mostFrequent = num;
                        } else if (freq[num] == maxFreq && num > mostFrequent) {
                            mostFrequent = num;
                        }
                    }
                    x += dx[k];
                    y += dy[k];
                }
            }
        }
    }

    return mostFrequent;
}