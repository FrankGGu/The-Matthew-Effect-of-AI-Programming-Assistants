#include <stdbool.h>

int countWays(int* a, int aSize, int* b, int bSize) {
    if (aSize != bSize) return 0;
    int degreeA[100001] = {0}, degreeB[100001] = {0};
    for (int i = 0; i < aSize - 1; i++) {
        degreeA[a[i]]++;
        degreeA[a[i + 1]]++;
    }
    for (int i = 0; i < bSize - 1; i++) {
        degreeB[b[i]]++;
        degreeB[b[i + 1]]++;
    }
    for (int i = 1; i <= 100000; i++) {
        if (degreeA[i] != degreeB[i]) return 0;
    }
    long long result = 1;
    for (int i = 0; i < aSize - 1; i++) {
        result = result * (degreeA[a[i]] + degreeA[a[i + 1]] - 1) % 1000000007;
        degreeA[a[i]]--;
        degreeA[a[i + 1]]--;
    }
    return (int)result;
}