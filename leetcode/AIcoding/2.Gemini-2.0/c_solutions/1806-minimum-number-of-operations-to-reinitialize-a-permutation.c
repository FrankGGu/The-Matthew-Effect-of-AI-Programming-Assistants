#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int reinitializePermutation(int n) {
    int count = 0;
    int arr[n];
    int perm[n];
    for (int i = 0; i < n; i++) {
        arr[i] = i;
        perm[i] = i;
    }
    count = 0;
    while (1) {
        int newArr[n];
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                newArr[i] = perm[i / 2];
            } else {
                newArr[i] = perm[n / 2 + (i - 1) / 2];
            }
        }
        count++;
        int flag = 1;
        for (int i = 0; i < n; i++) {
            if (newArr[i] != arr[i]) {
                flag = 0;
                break;
            }
        }
        if (flag == 1) {
            return count;
        }
        for (int i = 0; i < n; i++) {
            perm[i] = newArr[i];
        }
    }
}