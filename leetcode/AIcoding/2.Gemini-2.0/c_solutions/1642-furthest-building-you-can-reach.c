#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int furthestBuilding(int* heights, int heightsSize, int bricks, int ladders) {
    int* diffs = (int*)malloc(sizeof(int) * (heightsSize - 1));
    int diffsSize = 0;

    for (int i = 0; i < heightsSize - 1; i++) {
        if (heights[i + 1] > heights[i]) {
            diffs[diffsSize++] = heights[i + 1] - heights[i];
        }
    }

    int left = 0, right = diffsSize;
    int ans = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int* temp = (int*)malloc(sizeof(int) * diffsSize);
        for (int i = 0; i < diffsSize; i++) {
            temp[i] = diffs[i];
        }

        int* topK = (int*)malloc(sizeof(int) * mid);
        int topKSize = 0;
        for(int i = 0; i < diffsSize; i++){
            int val = temp[i];
            int j = topKSize;
            while(j > 0 && topK[j-1] < val){
                if(j < mid)
                    topK[j] = topK[j-1];
                j--;
            }
            if(j < mid){
                if(topKSize < mid){
                    topK[j] = val;
                    topKSize++;
                } else {
                     topK[j] = val;
                }

            }
        }

        long long bricksNeeded = 0;
        for(int i = 0; i < diffsSize; i++){
            int found = 0;
            for(int j = 0; j < mid; j++){
                if(diffs[i] == topK[j]){
                    topK[j] = -1;
                    found = 1;
                    break;
                }
            }
            if(!found){
                bricksNeeded += (long long)diffs[i];
            }
        }

        free(topK);
        free(temp);

        if (bricksNeeded <= bricks && mid <= ladders) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    free(diffs);
    return heightsSize - 1 + ans - diffsSize;
}