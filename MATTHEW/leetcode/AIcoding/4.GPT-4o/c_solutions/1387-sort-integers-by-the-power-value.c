#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int num;
    int power;
} PowerValue;

int power_of(int n) {
    int steps = 0;
    while (n != 1) {
        if (n % 2 == 0) {
            n /= 2;
        } else {
            n = 3 * n + 1;
        }
        steps++;
    }
    return steps;
}

int cmp(const void *a, const void *b) {
    PowerValue *pv1 = (PowerValue *)a;
    PowerValue *pv2 = (PowerValue *)b;
    if (pv1->power == pv2->power) {
        return pv1->num - pv2->num;
    }
    return pv1->power - pv2->power;
}

int getKth(int lo, int hi, int k) {
    int size = hi - lo + 1;
    PowerValue *arr = (PowerValue *)malloc(size * sizeof(PowerValue));

    for (int i = 0; i < size; i++) {
        arr[i].num = lo + i;
        arr[i].power = power_of(arr[i].num);
    }

    qsort(arr, size, sizeof(PowerValue), cmp);

    int result = arr[k - 1].num;
    free(arr);
    return result;
}