#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int movesToMakeZigzag(int* nums, int numsSize){
    if (numsSize <= 1) return 0;

    int evenMoves = 0;
    int oddMoves = 0;

    int* evenArr = (int*)malloc(numsSize * sizeof(int));
    int* oddArr = (int*)malloc(numsSize * sizeof(int));

    for(int i = 0; i < numsSize; i++){
        evenArr[i] = nums[i];
        oddArr[i] = nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            int left = (i > 0) ? evenArr[i - 1] : INT_MAX;
            int right = (i < numsSize - 1) ? evenArr[i + 1] : INT_MAX;

            int minNeighbor = (left < right) ? left : right;

            if (evenArr[i] >= minNeighbor) {
                evenMoves += evenArr[i] - minNeighbor + 1;
                evenArr[i] = minNeighbor - 1;
            }
        } else {
            int left = (i > 0) ? oddArr[i - 1] : INT_MAX;
            int right = (i < numsSize - 1) ? oddArr[i + 1] : INT_MAX;

            int minNeighbor = (left < right) ? left : right;

            if (oddArr[i] >= minNeighbor) {
                oddMoves += oddArr[i] - minNeighbor + 1;
                oddArr[i] = minNeighbor - 1;
            }
        }
    }

    free(evenArr);
    free(oddArr);

    return (evenMoves < oddMoves) ? evenMoves : oddMoves;
}