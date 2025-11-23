#include <string.h>

char *largestNumber(char *num, int *change, int changeSize) {
    int n = strlen(num);
    int start_mutation_idx = -1;

    for (int i = 0; i < n; i++) {
        int digit = num[i] - '0';
        if (change[digit] > digit) {
            start_mutation_idx = i;
            break;
        }
    }

    if (start_mutation_idx == -1) {
        return num;
    }

    for (int i = start_mutation_idx; i < n; i++) {
        int digit = num[i] - '0';
        if (change[digit] >= digit) {
            num[i] = change[digit] + '0';
        } else {
            break;
        }
    }

    return num;
}