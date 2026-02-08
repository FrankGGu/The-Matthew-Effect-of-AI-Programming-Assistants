#include <stdio.h>
#include <stdlib.h>

int countLargestGroup(int n) {
    int* groups = (int*)calloc(n + 1, sizeof(int));
    for (int i = 1; i <= n; i++) {
        int sum = 0;
        int num = i;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        groups[sum]++;
    }

    int max_size = 0;
    for (int i = 0; i <= n; i++) {
        if (groups[i] > max_size) {
            max_size = groups[i];
        }
    }

    int count = 0;
    for (int i = 0; i <= n; i++) {
        if (groups[i] == max_size) {
            count++;
        }
    }

    free(groups);
    return count;
}