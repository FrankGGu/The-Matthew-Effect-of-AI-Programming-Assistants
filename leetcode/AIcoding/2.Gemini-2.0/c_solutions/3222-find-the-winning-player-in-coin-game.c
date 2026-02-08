#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheWinner(int n, int k) {
    int ans = 0;
    for (int i = 2; i <= n; i++) {
        ans = (ans + k) % i;
    }
    return ans + 1;
}