#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheDistanceValue(int* arr1, int arr1Size, int* arr2, int arr2Size, int d) {
    int count = 0;
    for (int i = 0; i < arr1Size; i++) {
        bool found = false;
        for (int j = 0; j < arr2Size; j++) {
            if (abs(arr1[i] - arr2[j]) <= d) {
                found = true;
                break;
            }
        }
        if (!found) {
            count++;
        }
    }
    return count;
}