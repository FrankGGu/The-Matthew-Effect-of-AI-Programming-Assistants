#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int wardrobe(int n, int m, int* arr) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (arr[i] >= m) {
            count++;
        }
    }
    return count;
}