#include <stdlib.h>

int reachNumber(int target) {
    target = abs(target);
    int k = 0;
    long long sum = 0;

    while (sum < target || (sum - target) % 2 != 0) {
        k++;
        sum += k;
    }

    return k;
}