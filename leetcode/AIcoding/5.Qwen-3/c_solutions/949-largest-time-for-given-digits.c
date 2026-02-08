#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

char* largestTimeFromDigits(int* arr, int arrSize) {
    int maxTime = -1;
    int temp[4];
    for (int i = 0; i < 4; i++) {
        temp[i] = arr[i];
    }

    qsort(temp, 4, sizeof(int), compare);

    do {
        int h1 = temp[0], h2 = temp[1], m1 = temp[2], m2 = temp[3];
        int hours = h1 * 10 + h2;
        int minutes = m1 * 10 + m2;

        if (hours < 24 && minutes < 60) {
            int time = hours * 60 + minutes;
            if (time > maxTime) {
                maxTime = time;
            }
        }
    } while (next_permutation(temp, temp + 4));

    if (maxTime == -1) {
        return "Invalid";
    }

    int hours = maxTime / 60;
    int minutes = maxTime % 60;

    char* result = (char*)malloc(6 * sizeof(char));
    sprintf(result, "%02d:%02d", hours, minutes);
    return result;
}