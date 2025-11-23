#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int breakfastNumber(int* staple, int stapleSize, int* drinks, int drinksSize, int x) {
    qsort(staple, stapleSize, sizeof(int), compare);
    qsort(drinks, drinksSize, sizeof(int), compare);

    long long count = 0;
    int MOD = 1e9 + 7;

    int j = drinksSize - 1;

    for (int i = 0; i < stapleSize; ++i) {
        while (j >= 0 && staple[i] + drinks[j] > x) {
            j--;
        }
        if (j < 0) {
            break;
        }
        count = (count + (j + 1)) % MOD;
    }

    return (int)count;
}