#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * largestWordCount(char ** messages, int messagesSize, char ** senders, int sendersSize){
    int *counts = (int*)malloc(sizeof(int) * sendersSize);
    memset(counts, 0, sizeof(int) * sendersSize);
    char *result = NULL;
    int maxCount = -1;

    for (int i = 0; i < messagesSize; i++) {
        int wordCount = 1;
        for (int j = 0; messages[i][j] != '\0'; j++) {
            if (messages[i][j] == ' ') {
                wordCount++;
            }
        }

        int senderIndex = -1;
        for (int k = 0; k < sendersSize; k++) {
            if (strcmp(senders[i], senders[k]) == 0) {
                senderIndex = k;
                break;
            }
        }

        counts[i] = wordCount;
    }

    for (int i = 0; i < sendersSize; i++) {
        int wordCount = 1;
        for (int j = 0; messages[i][j] != '\0'; j++) {
            if (messages[i][j] == ' ') {
                wordCount++;
            }
        }

        if (wordCount > maxCount) {
            maxCount = wordCount;
            result = senders[i];
        } else if (wordCount == maxCount) {
            if (strcmp(senders[i], result) > 0) {
                result = senders[i];
            }
        }
    }

    int * totalCounts = (int*)malloc(sizeof(int) * sendersSize);
    memset(totalCounts, 0, sizeof(int) * sendersSize);

    for(int i=0; i<messagesSize; i++){
        int wordCount = 1;
        for (int j = 0; messages[i][j] != '\0'; j++) {
            if (messages[i][j] == ' ') {
                wordCount++;
            }
        }
        for(int k=0; k<sendersSize; k++){
            if(strcmp(senders[i], senders[k]) == 0){
                totalCounts[k] += wordCount;
                break;
            }
        }
    }

    maxCount = -1;
    result = NULL;

    for(int i=0; i<sendersSize; i++){
        if(totalCounts[i] > maxCount){
            maxCount = totalCounts[i];
            result = senders[i];
        } else if (totalCounts[i] == maxCount){
            if(strcmp(senders[i], result) > 0){
                result = senders[i];
            }
        }
    }

    free(counts);
    free(totalCounts);
    return result;
}