#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int num;
    int power;
} Pair;

int getPower(int n) {
    int power = 0;
    while (n != 1) {
        if (n % 2 == 0) {
            n /= 2;
        } else {
            n = 3 * n + 1;
        }
        power++;
    }
    return power;
}

int compare(const void *a, const void *b) {
    Pair *p1 = (Pair *)a;
    Pair *p2 = (Pair *)b;
    if (p1->power != p2->power) {
        return p1->power - p2->power;
    } else {
        return p1->num - p2->num;
    }
}

int getKth(int lo, int hi, int k) {
    Pair arr[hi - lo + 1];
    for (int i = lo; i <= hi; i++) {
        arr[i - lo].num = i;
        arr[i - lo].power = getPower(i);
    }
    qsort(arr, hi - lo + 1, sizeof(Pair), compare);
    return arr[k - 1].num;
}