#include <stdlib.h>
#include <stdbool.h>

typedef long long ll;

bool isPossible(int* target, int targetSize) {
    if (targetSize == 1) return target[0] == 1;

    ll sum = 0;
    int max_idx = 0;

    for (int i = 0; i < targetSize; i++) {
        sum += target[i];
        if (target[i] > target[max_idx]) {
            max_idx = i;
        }
    }

    while (target[max_idx] > 1) {
        ll rest = sum - target[max_idx];

        if (rest == 1) return true;
        if (rest == 0 || target[max_idx] <= rest) return false;

        ll prev = target[max_idx] % rest;
        if (prev == 0) return false;

        sum = rest + prev;
        target[max_idx] = prev;

        max_idx = 0;
        for (int i = 0; i < targetSize; i++) {
            if (target[i] > target[max_idx]) {
                max_idx = i;
            }
        }
    }

    return true;
}