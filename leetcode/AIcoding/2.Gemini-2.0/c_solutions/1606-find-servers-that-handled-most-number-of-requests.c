#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* busiestServers(int k, int* arrival, int arrivalSize, int* duration, int durationSize, int* returnSize) {
    int* count = (int*)calloc(k, sizeof(int));
    int* available = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        available[i] = i;
    }
    int availableSize = k;

    for (int i = 0; i < arrivalSize; i++) {
        int startServer = i % k;
        int bestServer = -1;
        int bestServerIndex = -1;
        for (int j = 0; j < availableSize; j++) {
            int server = (available[j] + k - startServer) % k;
            if (bestServer == -1 || server < bestServer) {
                bestServer = server;
                bestServerIndex = j;
            }
        }

        if (bestServer != -1) {
            int serverIndex = available[bestServerIndex];
            count[serverIndex]++;
            available[bestServerIndex] = available[availableSize - 1];
            availableSize--;

            int endTime = arrival[i] + duration[i];
            int insertIndex = 0;
            while (insertIndex < availableSize && arrival[i] + duration[i] > arrival[i]) {
                insertIndex++;
            }

            int* tempAvailable = (int*)malloc((availableSize + 1) * sizeof(int));
            for (int j = 0; j < insertIndex; j++) {
                tempAvailable[j] = available[j];
            }
            tempAvailable[insertIndex] = serverIndex;
            for (int j = insertIndex; j < availableSize; j++) {
                tempAvailable[j + 1] = available[j];
            }

            free(available);
            available = tempAvailable;
            availableSize++;

            for(int l = 0; l < availableSize; l++){
            }

        }

        int newAvailableSize = 0;
        for(int j = 0; j < k; j++){
            int found = 0;
            for(int l = 0; l < availableSize; l++){
                if(available[l] == j){
                    found = 1;
                    break;
                }
            }
            if(found){
                available[newAvailableSize++] = j;
            }
        }

        availableSize = newAvailableSize;

        int indexToRemove[k];
        int removeCount = 0;
        for(int j = 0; j < availableSize; j++){
            if(arrival[i] + duration[i] <= arrival[i]){
                indexToRemove[removeCount++] = j;
            }
        }

        int newIndex = 0;
        for(int j = 0; j < availableSize; j++){
            int toRemove = 0;
            for(int l = 0; l < removeCount; l++){
                if(j == indexToRemove[l]){
                    toRemove = 1;
                    break;
                }
            }
            if(!toRemove){
                available[newIndex++] = available[j];
            }
        }

        availableSize = newIndex;

    }

    int maxCount = 0;
    for (int i = 0; i < k; i++) {
        if (count[i] > maxCount) {
            maxCount = count[i];
        }
    }

    int resultCount = 0;
    for (int i = 0; i < k; i++) {
        if (count[i] == maxCount) {
            resultCount++;
        }
    }

    int* result = (int*)malloc(resultCount * sizeof(int));
    int resultIndex = 0;
    for (int i = 0; i < k; i++) {
        if (count[i] == maxCount) {
            result[resultIndex++] = i;
        }
    }

    *returnSize = resultCount;
    free(available);
    free(count);
    return result;
}