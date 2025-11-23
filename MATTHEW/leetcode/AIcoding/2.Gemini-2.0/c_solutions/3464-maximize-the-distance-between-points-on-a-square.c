#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double solve() {
    int n;
    scanf("%d", &n);
    if (n <= 2) {
        return 0.0;
    } else if (n == 3) {
        return sqrt(2.0);
    } else {
        return 2.0;
    }
}