#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int magicalString(int n) {
    if (n <= 0) return 0;
    if (n <= 3) return 1;

    int *s = (int*)malloc(sizeof(int) * n);
    s[0] = 1;
    s[1] = 2;
    s[2] = 2;

    int head = 2, tail = 3, num = 1, count = 1;

    while (tail < n) {
        for (int i = 0; i < s[head]; i++) {
            s[tail] = num;
            if (num == 1 && tail < n) count++;
            tail++;
            if (tail >= n) break;
        }
        num = num == 1 ? 2 : 1;
        head++;
    }

    free(s);
    return count;
}