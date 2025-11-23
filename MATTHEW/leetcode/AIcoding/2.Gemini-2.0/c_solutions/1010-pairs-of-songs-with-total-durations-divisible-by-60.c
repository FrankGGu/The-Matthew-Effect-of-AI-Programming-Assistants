#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numPairsDivisibleBy60(int* time, int timeSize){
    int count = 0;
    int remainders[60] = {0};
    for (int i = 0; i < timeSize; i++) {
        int remainder = time[i] % 60;
        int complement = (60 - remainder) % 60;
        count += remainders[complement];
        remainders[remainder]++;
    }
    return count;
}