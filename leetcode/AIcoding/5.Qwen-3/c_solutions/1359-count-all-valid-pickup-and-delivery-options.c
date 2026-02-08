#include <stdio.h>
#include <stdlib.h>

long long countOrders(int n) {
    long long result = 1;
    for (int i = 2; i <= n; i++) {
        result = result * (2 * i - 1) * i;
    }
    return result;
}