#include <stdlib.h> // Required for abs()

int findTheDistanceValue(int* arr1, int arr1Size, int* arr2, int arr2Size, int d) {
    int distanceValueCount = 0;

    for (int i = 0; i < arr1Size; i++) {
        int num1 = arr1[i];
        int isValid = 1; // Assume arr1[i] is valid initially

        for (int j = 0; j < arr2Size; j++) {
            int num2 = arr2[j];
            if (abs(num1 - num2) <= d) {
                isValid = 0; // arr1[i] is not valid
                break;       // No need to check further elements in arr2 for this arr1[i]
            }
        }

        if (isValid) {
            distanceValueCount++;
        }
    }

    return distanceValueCount;
}