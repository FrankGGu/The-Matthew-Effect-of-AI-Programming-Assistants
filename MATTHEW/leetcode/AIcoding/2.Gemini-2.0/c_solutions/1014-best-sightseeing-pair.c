#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxScoreSightseeingPair(int* values, int valuesSize){
    int max_score = 0;
    int current_max = values[0] + 0;

    for (int j = 1; j < valuesSize; j++) {
        max_score = (max_score > current_max + values[j] - j) ? max_score : current_max + values[j] - j;
        current_max = (current_max > values[j] + j) ? current_max : values[j] + j;
    }

    return max_score;
}