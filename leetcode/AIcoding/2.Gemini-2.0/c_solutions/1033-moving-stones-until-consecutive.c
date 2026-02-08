#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* numMovesStones(int a, int b, int c, int* returnSize){
    int arr[3] = {a, b, c};
    int temp;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2 - i; j++) {
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }

    int min_moves, max_moves;

    if (arr[1] - arr[0] == 1 && arr[2] - arr[1] == 1) {
        min_moves = 0;
    } else if (arr[1] - arr[0] <= 2 || arr[2] - arr[1] <= 2) {
        min_moves = 1;
    } else {
        min_moves = 2;
    }

    max_moves = arr[2] - arr[0] - 2;

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = min_moves;
    result[1] = max_moves;
    *returnSize = 2;
    return result;
}