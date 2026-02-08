#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumScore(int a, int b, int c) {
    int arr[3] = {a, b, c};
    int score = 0;
    while (1) {
        int max1_idx = 0;
        if (arr[1] > arr[0]) max1_idx = 1;
        if (arr[2] > arr[max1_idx]) max1_idx = 2;

        int max2_idx = (max1_idx + 1) % 3;
        if (arr[(max1_idx + 2) % 3] > arr[max2_idx]) max2_idx = (max1_idx + 2) % 3;

        if (arr[max1_idx] == 0 || arr[max2_idx] == 0) break;

        arr[max1_idx]--;
        arr[max2_idx]--;
        score++;
    }
    return score;
}