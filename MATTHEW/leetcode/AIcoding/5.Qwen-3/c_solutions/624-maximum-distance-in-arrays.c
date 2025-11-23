#include <stdio.h>
#include <stdlib.h>

int maximumDistance(int** arrays) {
    int min_val = INT_MAX;
    int max_val = INT_MIN;
    int min_index = -1;
    int max_index = -1;

    for (int i = 0; arrays[i] != NULL; i++) {
        int size = arrays[i][0];
        int* arr = &arrays[i][1];
        if (arr[0] < min_val) {
            min_val = arr[0];
            min_index = i;
        }
        if (arr[size - 1] > max_val) {
            max_val = arr[size - 1];
            max_index = i;
        }
    }

    if (min_index != max_index) {
        return max_val - min_val;
    } else {
        int second_min = INT_MAX;
        int second_max = INT_MIN;
        for (int i = 0; arrays[i] != NULL; i++) {
            int size = arrays[i][0];
            int* arr = &arrays[i][1];
            if (i != min_index && arr[0] < second_min) {
                second_min = arr[0];
            }
            if (i != max_index && arr[size - 1] > second_max) {
                second_max = arr[size - 1];
            }
        }
        return (second_max - min_val) > (max_val - second_min) ? (second_max - min_val) : (max_val - second_min);
    }
}