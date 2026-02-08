#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define MAX_VAL 1000000

bool isPrime[MAX_VAL + 1];
int freq[MAX_VAL + 1];

void sieve() {
    memset(isPrime, true, sizeof(isPrime));
    isPrime[0] = false;
    isPrime[1] = false;
    for (int p = 2; p * p <= MAX_VAL; p++) {
        if (isPrime[p]) {
            for (int i = p * p; i <= MAX_VAL; i += p)
                isPrime[i] = false;
        }
    }
}

int mostFrequentPrime(int** grid, int gridSize, int* gridColSize) {
    sieve();
    memset(freq, 0, sizeof(freq));

    int m = gridSize;
    int n = gridColSize[0];

    int dr[] = {-1, -1, -1, 0, 0, 1, 1, 1};
    int dc[] = {-1, 0, 1, -1, 1, -1, 0, 1};

    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            for (int i = 0; i < 8; i++) {
                int currentNumber = 0;
                int nr = r;
                int nc = c;

                while (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    currentNumber = currentNumber * 10 + grid[nr][nc];

                    if (currentNumber > MAX_VAL) {
                        break;
                    }

                    if (currentNumber >= 2 && isPrime[currentNumber]) {
                        freq[currentNumber]++;
                    }

                    nr += dr[i];
                    nc += dc[i];
                }
            }
        }
    }

    int maxFreq = -1;
    int resultPrime = -1;

    for (int p = MAX_VAL; p >= 2; p--) { 
        if (isPrime[p] && freq[p] > 0) {
            if (freq[p] > maxFreq) {
                maxFreq = freq[p];
                resultPrime = p;
            }
        }
    }

    return resultPrime;
}