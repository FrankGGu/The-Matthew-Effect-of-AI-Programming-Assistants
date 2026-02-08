#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int fillCups(int amount[]) {
    int a = amount[0], b = amount[1], c = amount[2];
    int arr[3] = {a, b, c};

    int max = arr[0];
    for (int i = 1; i < 3; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
    }

    int sum = a + b + c;

    if (max > sum - max) {
        return max;
    } else {
        return (sum + 1) / 2;
    }
}