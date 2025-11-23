#include <stdio.h>
#include <stdlib.h>

double binomialCoefficient(int n, int k) {
    if (k > n - k) k = n - k;
    double result = 1.0;
    for (int i = 0; i < k; ++i) {
        result *= (n - i);
        result /= (i + 1);
    }
    return result;
}

double meanOfArray(int* arr, int arrSize) {
    int n = arrSize;
    int k = n / 2;
    if (n % 2 == 0) k--;
    int totalElementsToTake = n - 2 * k;
    int* sortedArr = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        sortedArr[i] = arr[i];
    }
    for (int i = 0; i < n - 1; ++i) {
        for (int j = 0; j < n - i - 1; ++j) {
            if (sortedArr[j] > sortedArr[j + 1]) {
                int temp = sortedArr[j];
                sortedArr[j] = sortedArr[j + 1];
                sortedArr[j + 1] = temp;
            }
        }
    }
    double sum = 0.0;
    for (int i = k; i < n - k; ++i) {
        sum += sortedArr[i];
    }
    free(sortedArr);
    return sum / (n - 2 * k);
}