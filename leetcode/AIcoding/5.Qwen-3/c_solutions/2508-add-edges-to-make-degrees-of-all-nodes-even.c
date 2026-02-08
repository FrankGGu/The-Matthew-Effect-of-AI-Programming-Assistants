#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool isEven(int n) {
    return n % 2 == 0;
}

int countOddDegrees(int* degrees, int n) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (!isEven(degrees[i])) {
            count++;
        }
    }
    return count;
}

bool canMakeEven(int* degrees, int n) {
    int oddCount = countOddDegrees(degrees, n);
    return oddCount % 2 == 0;
}

bool canAddEdges(int* degrees, int n) {
    return canMakeEven(degrees, n);
}