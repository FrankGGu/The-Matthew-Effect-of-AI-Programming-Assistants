#include <stdio.h>
#include <stdlib.h>

int numOfWays(int n) {
    long long int a = 2, b = 2;
    for (int i = 1; i < n; i++) {
        long long int new_a = (a * 2 + b * 2) % 1000000007;
        long long int new_b = (a * 1 + b * 3) % 1000000007;
        a = new_a;
        b = new_b;
    }
    return (a + b) % 1000000007;
}