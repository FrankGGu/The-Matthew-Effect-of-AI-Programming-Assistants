#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* minOperations(char * boxes){
    int n = strlen(boxes);
    int *result = (int*)malloc(sizeof(int) * n);
    for(int i = 0; i < n; i++){
        result[i] = 0;
        for(int j = 0; j < n; j++){
            if(boxes[j] == '1'){
                result[i] += abs(i - j);
            }
        }
    }
    return result;
}