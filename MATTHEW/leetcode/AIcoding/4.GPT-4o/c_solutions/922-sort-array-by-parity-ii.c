#include <stdio.h>

void sortArrayByParityII(int* A, int ASize) {
    int oddIndex = 1;
    for (int i = 0; i < ASize; i += 2) {
        if (A[i] % 2 != 0) {
            while (A[oddIndex] % 2 != 0) {
                oddIndex += 2;
            }
            int temp = A[i];
            A[i] = A[oddIndex];
            A[oddIndex] = temp;
        }
    }
}