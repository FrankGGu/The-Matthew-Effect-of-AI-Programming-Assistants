#include <stdio.h>
#include <stdlib.h>

int distributeCandies(int n, int limit) {
    int count = 0;
    for (int i = 0; i <= limit && i <= n; i++) {
        for (int j = 0; j <= limit && i + j <= n; j++) {
            int k = n - i - j;
            if (k >= 0 && k <= limit) {
                count++;
            }
        }
    }
    return count;
}