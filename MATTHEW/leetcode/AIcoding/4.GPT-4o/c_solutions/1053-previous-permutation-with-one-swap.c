#include <stdio.h>

void prevPermOpt1(int* A, int ASize) {
    int i = ASize - 2;
    while (i >= 0 && A[i] <= A[i + 1]) {
        i--;
    }
    if (i >= 0) {
        int j = ASize - 1;
        while (A[j] >= A[i]) {
            j--;
        }
        while (j > 0 && A[j] == A[j - 1]) {
            j--;
        }
        int temp = A[i];
        A[i] = A[j];
        A[j] = temp;
    }
}