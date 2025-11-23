#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numTimesAllBlue(int* flips, int flipsSize){
    int count = 0;
    int max = 0;
    int sum = 0;
    for(int i = 0; i < flipsSize; i++){
        if(flips[i] > max){
            max = flips[i];
        }
        sum += flips[i];
        if(sum == (long long)max * (max + 1) / 2){
            count++;
        }
    }
    return count;
}