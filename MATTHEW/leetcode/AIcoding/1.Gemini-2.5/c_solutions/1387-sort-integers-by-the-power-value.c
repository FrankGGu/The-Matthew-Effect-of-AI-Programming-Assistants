#include <stdlib.h>

typedef struct {
    int num;
    int power;
} NumberInfo;

int calculatePower(int n) {
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

int compare(const void *a, const void *b) {
    NumberInfo *infoA = (NumberInfo *)a;
    NumberInfo *infoB = (NumberInfo *)b;

    if (infoA->power != infoB->power) {
        return infoA->power - infoB->power;
    } else {
        return infoA->num - infoB->num;
    }
}

int getKth(int low, int high, int k) {
    int count = high - low + 1;
    NumberInfo *numbers = (NumberInfo *)malloc(count * sizeof(NumberInfo));

    for (int i = 0; i < count; i++) {
        numbers[i].num = low + i;
        numbers[i].power = calculatePower(low + i);
    }

    qsort(numbers, count, sizeof(NumberInfo), compare);

    int result = numbers[k - 1].num;

    free(numbers);

    return result;
}