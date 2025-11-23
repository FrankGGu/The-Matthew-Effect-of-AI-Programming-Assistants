#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * largestTimeFromDigits(int* arr, int arrSize){
    int max_time = -1;
    int perm[4];
    int used[4] = {0};

    void backtrack(int index) {
        if (index == 4) {
            int hour = perm[0] * 10 + perm[1];
            int minute = perm[2] * 10 + perm[3];
            if (hour < 24 && minute < 60) {
                int time = hour * 60 + minute;
                if (time > max_time) {
                    max_time = time;
                }
            }
            return;
        }

        for (int i = 0; i < arrSize; i++) {
            if (!used[i]) {
                perm[index] = arr[i];
                used[i] = 1;
                backtrack(index + 1);
                used[i] = 0;
            }
        }
    }

    backtrack(0);

    if (max_time == -1) {
        return "";
    }

    char *result = (char *)malloc(6 * sizeof(char));
    sprintf(result, "%02d:%02d", max_time / 60, max_time % 60);
    return result;
}