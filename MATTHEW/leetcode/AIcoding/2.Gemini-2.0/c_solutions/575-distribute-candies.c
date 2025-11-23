#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distributeCandies(int* candyType, int candyTypeSize){
    int count = 0;
    bool seen[100001] = {false};
    for (int i = 0; i < candyTypeSize; i++) {
        int type = candyType[i] + 50000;
        if (!seen[type]) {
            seen[type] = true;
            count++;
        }
    }
    return (count > candyTypeSize / 2) ? candyTypeSize / 2 : count;
}