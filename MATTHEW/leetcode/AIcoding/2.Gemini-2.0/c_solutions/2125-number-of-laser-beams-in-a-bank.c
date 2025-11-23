#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfBeams(char ** bank, int bankSize){
    int prevRowCount = 0;
    int totalBeams = 0;

    for(int i = 0; i < bankSize; i++){
        int currentRowCount = 0;
        for(int j = 0; bank[i][j] != '\0'; j++){
            if(bank[i][j] == '1'){
                currentRowCount++;
            }
        }

        if(currentRowCount > 0){
            totalBeams += prevRowCount * currentRowCount;
            prevRowCount = currentRowCount;
        }
    }

    return totalBeams;
}