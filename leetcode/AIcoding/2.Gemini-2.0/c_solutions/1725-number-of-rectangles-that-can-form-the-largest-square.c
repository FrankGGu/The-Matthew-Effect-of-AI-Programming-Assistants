#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countGoodRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize){
    int maxLen = 0;
    int count = 0;
    for(int i = 0; i < rectanglesSize; i++){
        int side = rectangles[i][0] < rectangles[i][1] ? rectangles[i][0] : rectangles[i][1];
        if(side > maxLen){
            maxLen = side;
            count = 1;
        } else if(side == maxLen){
            count++;
        }
    }
    return count;
}