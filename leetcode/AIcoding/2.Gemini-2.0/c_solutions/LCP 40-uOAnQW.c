#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxScoreSightseeingPair(int* values, int valuesSize){
    int max_score = 0;
    int max_val = values[0] + 0;

    for (int j = 1; j < valuesSize; j++) {
        int score = max_val + values[j] - j;
        if (score > max_score) {
            max_score = score;
        }
        if (values[j] + j > max_val) {
            max_val = values[j] + j;
        }
    }

    return max_score;
}