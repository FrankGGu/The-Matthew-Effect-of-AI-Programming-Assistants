#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lastStoneWeight(int* stones, int stonesSize) {
    if (stonesSize == 0) return 0;
    if (stonesSize == 1) return stones[0];

    while (stonesSize > 1) {
        int max1 = 0, max2 = 0, index1 = -1, index2 = -1;
        for (int i = 0; i < stonesSize; i++) {
            if (stones[i] > max1) {
                max2 = max1;
                index2 = index1;
                max1 = stones[i];
                index1 = i;
            } else if (stones[i] > max2) {
                max2 = stones[i];
                index2 = i;
            }
        }

        if (max1 == max2) {
            if(index1 < index2){
                for(int i = index1; i < stonesSize - 2; i++){
                    stones[i] = stones[i+1];
                }
                 stonesSize -= 2;
            }else{
                for(int i = index2; i < stonesSize - 2; i++){
                    stones[i] = stones[i+1];
                }
                 stonesSize -= 2;
            }

        } else {
            stones[index1] = max1 - max2;
             if(index2 < index1){
                for(int i = index2; i < stonesSize - 1; i++){
                    stones[i] = stones[i+1];
                }
            }else{
                for(int i = index2; i < stonesSize - 1; i++){
                    stones[i] = stones[i+1];
                }
            }

            stonesSize--;
        }
    }

    if (stonesSize == 0) return 0;
    return stones[0];
}